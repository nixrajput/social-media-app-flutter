import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rippl/data/api/token_store.dart';
import 'package:rippl/data/repositories/auth_repository_impl.dart';
import 'package:rippl/domain/models/auth_session.dart';
import 'package:rippl/domain/models/auth_state.dart';
import 'package:rippl/domain/models/auth_tokens.dart';
import 'package:rippl/domain/models/login_result.dart';
import 'package:rippl/domain/models/oauth_result.dart';
import 'package:rippl/domain/models/user.dart';
import 'package:rippl/domain/repositories/auth_repository.dart';
import 'package:rippl/features/auth/presentation/auth_controller.dart';
import 'package:rippl/services/google_sign_in_service.dart';
import 'package:rippl/services/secure_store.dart';

class _Repo extends Mock implements AuthRepository {}

class _FakeGoogle implements GoogleSignInService {
  _FakeGoogle(this._token);
  final String? _token;
  @override
  Future<String?> signInIdToken() async => _token;
}

class _NullStore implements TokenStore {
  @override
  Future<String?> readAccess() async => null;
  @override
  Future<String?> readRefresh() async => null;
  @override
  Future<void> writeTokens({
    required String access,
    required String refresh,
  }) async {}
  @override
  Future<void> clear() async {}
}

AuthSession _session() => AuthSession(
  user: User(
    id: 'u1',
    username: 'nik',
    email: 'n@e.com',
    createdAt: DateTime(2026),
  ),
  tokens: AuthTokens(
    accessToken: 'A',
    accessExpiresAt: DateTime(2026),
    refreshToken: 'R',
    refreshExpiresAt: DateTime(2026, 2),
  ),
  deviceId: 'd1',
);

void main() {
  test('login success moves state to authenticated', () async {
    final repo = _Repo();
    when(
      () => repo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
        deviceName: any(named: 'deviceName'),
        platform: any(named: 'platform'),
      ),
    ).thenAnswer((_) async => LoginSuccess(_session()));

    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        tokenStoreProvider.overrideWithValue(_NullStore()),
      ],
    );
    addTearDown(container.dispose);
    await container.read(authControllerProvider.future);
    await container
        .read(authControllerProvider.notifier)
        .login(email: 'n@e.com', password: 'x');
    expect(
      container.read(authControllerProvider).value,
      isA<AuthAuthenticated>(),
    );
  });

  test('login requiring 2fa moves state to twoFactorPending', () async {
    final repo = _Repo();
    when(
      () => repo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
        deviceName: any(named: 'deviceName'),
        platform: any(named: 'platform'),
      ),
    ).thenAnswer((_) async => const LoginTwoFactor('chal'));

    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        tokenStoreProvider.overrideWithValue(_NullStore()),
      ],
    );
    addTearDown(container.dispose);
    await container.read(authControllerProvider.future);
    await container
        .read(authControllerProvider.notifier)
        .login(email: 'n@e.com', password: 'x');
    expect(
      container.read(authControllerProvider).value,
      isA<AuthTwoFactorPending>(),
    );
  });

  test('google login needing profile moves state to profileSetup', () async {
    final repo = _Repo();
    when(
      () => repo.oauthLogin(
        provider: any(named: 'provider'),
        idToken: any(named: 'idToken'),
        deviceName: any(named: 'deviceName'),
        platform: any(named: 'platform'),
      ),
    ).thenAnswer(
      (_) async => OAuthResult(session: _session(), needsProfile: true),
    );

    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        tokenStoreProvider.overrideWithValue(_NullStore()),
        googleSignInServiceProvider.overrideWithValue(_FakeGoogle('idtok')),
      ],
    );
    addTearDown(container.dispose);
    await container.read(authControllerProvider.future);
    await container.read(authControllerProvider.notifier).loginWithGoogle();
    expect(
      container.read(authControllerProvider).value,
      isA<AuthProfileSetup>(),
    );
  });

  test(
    'google login not needing profile moves state to authenticated',
    () async {
      final repo = _Repo();
      when(
        () => repo.oauthLogin(
          provider: any(named: 'provider'),
          idToken: any(named: 'idToken'),
          deviceName: any(named: 'deviceName'),
          platform: any(named: 'platform'),
        ),
      ).thenAnswer(
        (_) async => OAuthResult(session: _session(), needsProfile: false),
      );

      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(repo),
          tokenStoreProvider.overrideWithValue(_NullStore()),
          googleSignInServiceProvider.overrideWithValue(_FakeGoogle('idtok')),
        ],
      );
      addTearDown(container.dispose);
      await container.read(authControllerProvider.future);
      await container.read(authControllerProvider.notifier).loginWithGoogle();
      expect(
        container.read(authControllerProvider).value,
        isA<AuthAuthenticated>(),
      );
    },
  );

  test('google login cancelled leaves state unchanged', () async {
    final repo = _Repo();
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        tokenStoreProvider.overrideWithValue(_NullStore()),
        googleSignInServiceProvider.overrideWithValue(_FakeGoogle(null)),
      ],
    );
    addTearDown(container.dispose);
    await container.read(authControllerProvider.future);
    await container.read(authControllerProvider.notifier).loginWithGoogle();
    expect(
      container.read(authControllerProvider).value,
      isA<AuthUnauthenticated>(),
    );
    verifyNever(
      () => repo.oauthLogin(
        provider: any(named: 'provider'),
        idToken: any(named: 'idToken'),
        deviceName: any(named: 'deviceName'),
        platform: any(named: 'platform'),
      ),
    );
  });
}

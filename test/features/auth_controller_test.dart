import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rippl/data/api/token_store.dart';
import 'package:rippl/data/repositories/auth_repository_impl.dart';
import 'package:rippl/domain/models/auth_session.dart';
import 'package:rippl/domain/models/auth_state.dart';
import 'package:rippl/domain/models/auth_tokens.dart';
import 'package:rippl/domain/models/login_result.dart';
import 'package:rippl/domain/models/user.dart';
import 'package:rippl/domain/repositories/auth_repository.dart';
import 'package:rippl/features/auth/presentation/auth_controller.dart';
import 'package:rippl/services/secure_store.dart';

class _Repo extends Mock implements AuthRepository {}

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
}

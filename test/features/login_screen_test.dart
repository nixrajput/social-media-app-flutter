import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rippl/core/design/app_theme.dart';
import 'package:rippl/data/api/token_store.dart';
import 'package:rippl/data/repositories/auth_repository_impl.dart';
import 'package:rippl/domain/models/auth_session.dart';
import 'package:rippl/domain/models/auth_tokens.dart';
import 'package:rippl/domain/models/login_result.dart';
import 'package:rippl/domain/models/user.dart';
import 'package:rippl/domain/repositories/auth_repository.dart';
import 'package:rippl/features/auth/presentation/login_screen.dart';
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

void main() {
  testWidgets('entering credentials calls login', (tester) async {
    final repo = _Repo();
    when(
      () => repo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
        deviceName: any(named: 'deviceName'),
        platform: any(named: 'platform'),
      ),
    ).thenAnswer(
      (_) async => LoginSuccess(
        AuthSession(
          user: User(
            id: 'u',
            username: 'n',
            email: 'e',
            createdAt: DateTime(2026),
          ),
          tokens: AuthTokens(
            accessToken: 'a',
            accessExpiresAt: DateTime(2026),
            refreshToken: 'r',
            refreshExpiresAt: DateTime(2026, 2),
          ),
          deviceId: 'd',
        ),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repo),
          tokenStoreProvider.overrideWithValue(_NullStore()),
        ],
        child: MaterialApp(
          theme: buildTheme(Brightness.light),
          home: const LoginScreen(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).first, 'n@e.com');
    await tester.enterText(find.byType(TextField).last, 'secret123');
    await tester.tap(find.text('Log in'));
    await tester.pump();

    verify(
      () => repo.login(
        email: 'n@e.com',
        password: 'secret123',
        deviceName: any(named: 'deviceName'),
        platform: any(named: 'platform'),
      ),
    ).called(1);
  });
}

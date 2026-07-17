import 'package:flutter_test/flutter_test.dart';
import 'package:rippl/core/router/redirect.dart';
import 'package:rippl/core/router/routes.dart';
import 'package:rippl/domain/models/auth_session.dart';
import 'package:rippl/domain/models/auth_state.dart';
import 'package:rippl/domain/models/auth_tokens.dart';
import 'package:rippl/domain/models/user.dart';

AuthState _authed() => AuthState.authenticated(
  AuthSession(
    user: User(id: 'u', username: 'n', email: 'e', createdAt: DateTime(2026)),
    tokens: AuthTokens(
      accessToken: 'a',
      accessExpiresAt: DateTime(2026),
      refreshToken: 'r',
      refreshExpiresAt: DateTime(2026, 2),
    ),
    deviceId: 'd',
  ),
);

void main() {
  test('unauthenticated user on a protected route is sent to welcome', () {
    expect(
      redirectFor(const AuthState.unauthenticated(), Routes.home),
      Routes.welcome,
    );
  });

  test('authenticated user on welcome is sent home', () {
    expect(redirectFor(_authed(), Routes.welcome), Routes.home);
  });

  test('twoFactorPending forces the 2fa screen', () {
    expect(
      redirectFor(const AuthState.twoFactorPending('c'), Routes.home),
      Routes.twoFactor,
    );
  });

  test('no redirect when already on the right place', () {
    expect(redirectFor(_authed(), Routes.home), isNull);
  });
}

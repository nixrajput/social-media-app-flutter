import 'package:flutter_test/flutter_test.dart';
import 'package:rippl/core/router/redirect.dart';
import 'package:rippl/core/router/routes.dart';
import 'package:rippl/domain/models/auth_session.dart';
import 'package:rippl/domain/models/auth_state.dart';
import 'package:rippl/domain/models/auth_tokens.dart';
import 'package:rippl/domain/models/user.dart';

AuthSession _session() => AuthSession(
  user: User(id: 'u', username: 'n', email: 'e', createdAt: DateTime(2026)),
  tokens: AuthTokens(
    accessToken: 'a',
    accessExpiresAt: DateTime(2026),
    refreshToken: 'r',
    refreshExpiresAt: DateTime(2026, 2),
  ),
  deviceId: 'd',
);

AuthState _authed() => AuthState.authenticated(_session());

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

  test('profileSetup forces the profile-setup screen', () {
    expect(
      redirectFor(AuthState.profileSetup(_session()), Routes.home),
      Routes.profileSetup,
    );
  });

  test('unauthenticated user is moved off splash to welcome', () {
    expect(
      redirectFor(const AuthState.unauthenticated(), Routes.splash),
      Routes.welcome,
    );
  });

  test('authenticated user is moved off splash to home', () {
    expect(redirectFor(_authed(), Routes.splash), Routes.home);
  });

  test('unknown auth state holds on splash while resolving', () {
    expect(redirectFor(const AuthState.unknown(), Routes.splash), isNull);
  });
}

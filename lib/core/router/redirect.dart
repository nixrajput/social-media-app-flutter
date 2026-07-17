import '../../domain/models/auth_state.dart';
import 'routes.dart';

const _publicRoutes = {
  Routes.welcome,
  Routes.login,
  Routes.register,
  Routes.otp,
  Routes.splash,
};

// Pure redirect policy. Returns the path to redirect to, or null to stay.
String? redirectFor(AuthState state, String location) {
  return switch (state) {
    AuthUnknown() => null,
    AuthTwoFactorPending() =>
      location == Routes.twoFactor ? null : Routes.twoFactor,
    AuthUnauthenticated() =>
      _publicRoutes.contains(location) ? null : Routes.welcome,
    AuthAuthenticated() =>
      _publicRoutes.contains(location) ? Routes.home : null,
  };
}

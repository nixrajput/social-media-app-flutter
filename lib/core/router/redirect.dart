import '../../domain/models/auth_state.dart';
import 'routes.dart';

const _publicRoutes = {
  Routes.welcome,
  Routes.login,
  Routes.register,
  Routes.otp,
};

// Pure redirect policy. Returns the path to redirect to, or null to stay.
// Splash (`/`) is a transient boot route: hold there only while auth is still
// resolving (unknown); once resolved, always leave it (home or welcome).
String? redirectFor(AuthState state, String location) {
  return switch (state) {
    AuthTwoFactorPending() =>
      location == Routes.twoFactor ? null : Routes.twoFactor,
    AuthProfileSetup() =>
      location == Routes.profileSetup ? null : Routes.profileSetup,
    AuthUnauthenticated() =>
      _publicRoutes.contains(location) ? null : Routes.welcome,
    // 'unknown' carries a stored token: navigate as if authenticated and let a
    // 401 (via the auth interceptor) demote to unauthenticated later.
    AuthUnknown() || AuthAuthenticated() =>
      _publicRoutes.contains(location) || location == Routes.splash
          ? Routes.home
          : null,
  };
}

part of 'app_pages.dart';

abstract class AppRoutes {
  static const home = _Routes.home;
  static const settings = _Routes.settings;
}

abstract class _Routes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset_password';
  static const settings = '/settings';
}

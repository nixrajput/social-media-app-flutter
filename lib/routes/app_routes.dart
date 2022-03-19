part of 'app_pages.dart';

abstract class AppRoutes {
  static const home = _Routes.home;
  static const settings = _Routes.settings;
  static const login = _Routes.login;
  static const register = _Routes.register;
  static const forgotPassword = _Routes.forgotPassword;
  static const resetPassword = _Routes.resetPassword;
  static const splash = _Routes.splash;
}

abstract class _Routes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset_password';
  static const settings = '/settings';
  static const splash = '/';
}

import 'package:get/get.dart';
import 'package:social_media_app/modules/auth/bindings/login_binding.dart';
import 'package:social_media_app/modules/auth/bindings/password_binding.dart';
import 'package:social_media_app/modules/auth/bindings/register_binding.dart';
import 'package:social_media_app/modules/auth/views/forgot_password_view.dart';
import 'package:social_media_app/modules/auth/views/login_view.dart';
import 'package:social_media_app/modules/auth/views/register_view.dart';
import 'package:social_media_app/modules/auth/views/reset_password_view.dart';
import 'package:social_media_app/modules/home/bindings/home_binding.dart';
import 'package:social_media_app/modules/home/views/home_view.dart';
import 'package:social_media_app/modules/settings/views/settings_view.dart';
import 'package:social_media_app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

abstract class AppPages {
  static var transitionDuration = const Duration(milliseconds: 300);

  static final pages = [
    GetPage(
      name: _Routes.splash,
      page: SplashView.new,
      transitionDuration: transitionDuration,
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.login,
      page: LoginView.new,
      transitionDuration: transitionDuration,
      binding: LoginBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.register,
      page: RegisterView.new,
      transitionDuration: transitionDuration,
      binding: RegisterBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.home,
      page: HomeView.new,
      transitionDuration: transitionDuration,
      binding: HomeBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.settings,
      page: SettingsView.new,
      transitionDuration: transitionDuration,
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.forgotPassword,
      page: ForgotPasswordView.new,
      transitionDuration: transitionDuration,
      binding: PasswordBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.resetPassword,
      page: ResetPasswordView.new,
      transitionDuration: transitionDuration,
      binding: PasswordBinding(),
      transition: Transition.downToUp,
    ),
  ];
}

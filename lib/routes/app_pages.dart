import 'package:get/get.dart';
import 'package:social_media_app/modules/auth/bindings/login_binding.dart';
import 'package:social_media_app/modules/auth/bindings/password_binding.dart';
import 'package:social_media_app/modules/auth/bindings/register_binding.dart';
import 'package:social_media_app/modules/auth/views/forgot_password_view.dart';
import 'package:social_media_app/modules/auth/views/login_view.dart';
import 'package:social_media_app/modules/auth/views/register_view.dart';
import 'package:social_media_app/modules/auth/views/reset_password_view.dart';
import 'package:social_media_app/modules/error/views/error_view.dart';
import 'package:social_media_app/modules/home/bindings/home_binding.dart';
import 'package:social_media_app/modules/home/views/home_view.dart';
import 'package:social_media_app/modules/post/bindings/create_post_binding.dart';
import 'package:social_media_app/modules/post/bindings/post_details_binding.dart';
import 'package:social_media_app/modules/post/views/create_post_view.dart';
import 'package:social_media_app/modules/post/views/post_details_view.dart';
import 'package:social_media_app/modules/profile/bindings/about_binding.dart';
import 'package:social_media_app/modules/profile/bindings/change_password_binding.dart';
import 'package:social_media_app/modules/profile/bindings/dob_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_profile_binding.dart';
import 'package:social_media_app/modules/profile/bindings/followers_list_binding.dart';
import 'package:social_media_app/modules/profile/bindings/following_list_binding.dart';
import 'package:social_media_app/modules/profile/bindings/gender_binding.dart';
import 'package:social_media_app/modules/profile/bindings/name_binding.dart';
import 'package:social_media_app/modules/profile/bindings/username_binding.dart';
import 'package:social_media_app/modules/profile/views/change_password_view.dart';
import 'package:social_media_app/modules/profile/views/edit_about_view.dart';
import 'package:social_media_app/modules/profile/views/edit_dob_view.dart';
import 'package:social_media_app/modules/profile/views/edit_gender_view.dart';
import 'package:social_media_app/modules/profile/views/edit_name_view.dart';
import 'package:social_media_app/modules/profile/views/edit_profile_view.dart';
import 'package:social_media_app/modules/profile/views/edit_username_view.dart';
import 'package:social_media_app/modules/profile/views/followers_list_view.dart';
import 'package:social_media_app/modules/profile/views/following_list_view.dart';
import 'package:social_media_app/modules/settings/bindings/setting_bindings.dart';
import 'package:social_media_app/modules/settings/views/settings_view.dart';
import 'package:social_media_app/modules/splash/views/splash_view.dart';
import 'package:social_media_app/modules/users/bindings/user_profile_binding.dart';
import 'package:social_media_app/modules/users/views/user_profile_view.dart';

part 'app_routes.dart';

abstract class AppPages {
  static var transitionDuration = const Duration(milliseconds: 200);

  static final pages = [
    GetPage(
      name: _Routes.splash,
      page: SplashView.new,
      transitionDuration: transitionDuration,
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.error,
      page: ErrorView.new,
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
      binding: SettingBinding(),
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
    GetPage(
      name: _Routes.changePassword,
      page: ChangePasswordView.new,
      transitionDuration: transitionDuration,
      binding: ChangePasswordBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.editProfile,
      page: EditProfileView.new,
      transitionDuration: transitionDuration,
      binding: EditProfileBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.editName,
      page: EditNameView.new,
      transitionDuration: transitionDuration,
      binding: NameBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.editUsername,
      page: EditUsernameView.new,
      transitionDuration: transitionDuration,
      binding: UsernameBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.editAbout,
      page: EditAboutView.new,
      transitionDuration: transitionDuration,
      binding: AboutBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.editDob,
      page: EditDOBView.new,
      transitionDuration: transitionDuration,
      binding: DOBBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.editGender,
      page: EditGenderView.new,
      transitionDuration: transitionDuration,
      binding: GenderBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.createPost,
      page: CreatePostView.new,
      transitionDuration: transitionDuration,
      binding: CreatePostBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.followers,
      page: FollowersListView.new,
      binding: FollowersBinding(),
      transitionDuration: transitionDuration,
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.following,
      page: FollowingListView.new,
      binding: FollowingBinding(),
      transitionDuration: transitionDuration,
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.userProfile,
      page: UserProfileView.new,
      binding: UserProfileBinding(),
      transitionDuration: transitionDuration,
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.postDetails,
      page: PostDetailsView.new,
      binding: PostDetailsBinding(),
      transitionDuration: transitionDuration,
      transition: Transition.downToUp,
    ),
  ];
}

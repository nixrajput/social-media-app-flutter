import 'package:get/get.dart';
import 'package:social_media_app/modules/app_update/app_update_view.dart';
import 'package:social_media_app/modules/auth/bindings/account_verification_binding.dart';
import 'package:social_media_app/modules/auth/bindings/login_binding.dart';
import 'package:social_media_app/modules/auth/bindings/password_binding.dart';
import 'package:social_media_app/modules/auth/bindings/register_binding.dart';
import 'package:social_media_app/modules/auth/views/forgot_password_view.dart';
import 'package:social_media_app/modules/auth/views/login_view.dart';
import 'package:social_media_app/modules/auth/views/register_view.dart';
import 'package:social_media_app/modules/auth/views/reset_password_view.dart';
import 'package:social_media_app/modules/auth/views/send_account_verification_otp_view.dart';
import 'package:social_media_app/modules/auth/views/verify_account_view.dart';
import 'package:social_media_app/modules/follower/bindings/followers_list_binding.dart';
import 'package:social_media_app/modules/follower/bindings/following_list_binding.dart';
import 'package:social_media_app/modules/follower/views/followers_list_view.dart';
import 'package:social_media_app/modules/follower/views/following_list_view.dart';
import 'package:social_media_app/modules/home/bindings/initial_binding.dart';
import 'package:social_media_app/modules/home/views/home_view.dart';
import 'package:social_media_app/modules/post/bindings/create_post_binding.dart';
import 'package:social_media_app/modules/post/bindings/post_details_binding.dart';
import 'package:social_media_app/modules/post/bindings/post_liked_users_binding.dart';
import 'package:social_media_app/modules/post/views/add_caption_view.dart';
import 'package:social_media_app/modules/post/views/create_post_view.dart';
import 'package:social_media_app/modules/post/views/post_comment_view.dart';
import 'package:social_media_app/modules/post/views/post_details_view.dart';
import 'package:social_media_app/modules/post/views/post_liked_users_view.dart';
import 'package:social_media_app/modules/profile/bindings/edit_about_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_dob_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_gender_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_name_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_profession_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_profile_picture_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_username_binding.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_about_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_dob_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_gender_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_name_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_profession_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_username_view.dart';
import 'package:social_media_app/modules/profile/views/profile_details_view.dart';
import 'package:social_media_app/modules/settings/bindings/change_password_binding.dart';
import 'package:social_media_app/modules/settings/bindings/login_device_info_binding.dart';
import 'package:social_media_app/modules/settings/bindings/privacy_settings_binding.dart';
import 'package:social_media_app/modules/settings/bindings/setting_bindings.dart';
import 'package:social_media_app/modules/settings/views/pages/about_settings_view.dart';
import 'package:social_media_app/modules/settings/views/pages/account_settings_view.dart';
import 'package:social_media_app/modules/settings/views/pages/help_settings_view.dart';
import 'package:social_media_app/modules/settings/views/pages/privacy/account_privacy_view.dart';
import 'package:social_media_app/modules/settings/views/pages/privacy_settings_view.dart';
import 'package:social_media_app/modules/settings/views/pages/security/change_password_view.dart';
import 'package:social_media_app/modules/settings/views/pages/security/login_activity_view.dart';
import 'package:social_media_app/modules/settings/views/pages/security_settings_view.dart';
import 'package:social_media_app/modules/settings/views/pages/theme_settings_view.dart';
import 'package:social_media_app/modules/settings/views/settings_view.dart';
import 'package:social_media_app/modules/user/user_details_binding.dart';
import 'package:social_media_app/modules/user/user_profile_view.dart';
import 'package:social_media_app/modules/welcome/welcome_view.dart';

part 'app_routes.dart';

abstract class AppPages {
  static var transitionDuration = const Duration(milliseconds: 500);
  static var defaultTransition = Transition.circularReveal;

  static final pages = [
    GetPage(
      name: _Routes.welcome,
      page: WelcomeView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),
    GetPage(
      name: _Routes.login,
      page: LoginView.new,
      transitionDuration: transitionDuration,
      binding: LoginBinding(),
      transition: defaultTransition,
    ),
    GetPage(
      name: _Routes.register,
      page: RegisterView.new,
      transitionDuration: transitionDuration,
      binding: RegisterBinding(),
      transition: defaultTransition,
    ),
    GetPage(
      name: _Routes.home,
      page: HomeView.new,
      transitionDuration: transitionDuration,
      binding: InitialBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.forgotPassword,
      page: ForgotPasswordView.new,
      transitionDuration: transitionDuration,
      binding: PasswordBinding(),
      transition: defaultTransition,
    ),
    GetPage(
      name: _Routes.resetPassword,
      page: ResetPasswordView.new,
      transitionDuration: transitionDuration,
      binding: PasswordBinding(),
      transition: defaultTransition,
    ),

    /// Send Verify Account Otp
    GetPage(
      name: _Routes.sendVerifyAccountOtp,
      page: SendAccountVerificationOtpView.new,
      transitionDuration: transitionDuration,
      binding: AccountVerificationBinding(),
      transition: defaultTransition,
    ),

    /// Verify Account
    GetPage(
      name: _Routes.verifyAccount,
      page: VerifyAccountView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    /// Edit Profile Pages -----------------------------------------------------

    GetPage(
      name: _Routes.editProfile,
      page: ProfileDetailsView.new,
      transitionDuration: transitionDuration,
      binding: EditProfilePictureBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.editName,
      page: EditNameView.new,
      binding: EditNameBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.editUsername,
      page: EditUsernameView.new,
      binding: EditUsernameBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.editAbout,
      page: EditAboutView.new,
      binding: EditAboutBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.editDob,
      page: EditDOBView.new,
      binding: EditDOBBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.editGender,
      page: EditGenderView.new,
      binding: EditGenderBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.editProfession,
      page: EditProfessionView.new,
      binding: EditProfessionBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    /// Post Pages -------------------------------------------------------------

    GetPage(
      name: _Routes.createPost,
      page: CreatePostView.new,
      transitionDuration: transitionDuration,
      binding: CreatePostBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.addCaption,
      page: AddCaptionView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.comments,
      page: PostCommentView.new,
      binding: PostDetailsBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.postLikedUsers,
      page: PostLikedUsersView.new,
      binding: PostLikedUsersBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.postDetails,
      page: PostDetailsView.new,
      binding: PostDetailsBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    GetPage(
      name: _Routes.followers,
      page: FollowersListView.new,
      binding: FollowersBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.following,
      page: FollowingListView.new,
      binding: FollowingBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: "${_Routes.userProfile}/:userId",
      page: UserProfileView.new,
      binding: UserProfileBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    ///  Settings Pages --------------------------------------------------------

    GetPage(
      name: _Routes.settings,
      page: SettingsView.new,
      binding: SettingBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.accountSettings,
      page: AccountSettingsView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.securitySettings,
      page: SecuritySettingsView.new,
      binding: LoginDeviceInfoBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.privacySettings,
      page: PrivacySettingsView.new,
      binding: PrivacySettingBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.helpSettings,
      page: HelpSettingsView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.aboutSettings,
      page: AboutSettingsView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.themeSettings,
      page: ThemeSettingsView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    ///  SECURITY SETTINGS -----------------------------------------------------

    GetPage(
      name: _Routes.changePassword,
      page: ChangePasswordView.new,
      transitionDuration: transitionDuration,
      binding: ChangePasswordBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.loginActivitySettings,
      page: LoginActivityView.new,
      binding: LoginDeviceInfoBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    /// Privacy Settings -------------------------------------------------------

    GetPage(
      name: _Routes.accountPrivacySettings,
      page: AccountPrivacyView.new,
      binding: PrivacySettingBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    /// App Update -------------------------------------------------------------
    GetPage(
      name: _Routes.appUpdate,
      page: AppUpdateView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------
  ];
}

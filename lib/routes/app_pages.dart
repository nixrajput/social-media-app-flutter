import 'package:get/get.dart';
import 'package:social_media_app/modules/app_error/app_error_view.dart';
import 'package:social_media_app/modules/app_update/app_update_view.dart';
import 'package:social_media_app/modules/auth/bindings/login_binding.dart';
import 'package:social_media_app/modules/auth/bindings/password_binding.dart';
import 'package:social_media_app/modules/auth/bindings/reactivate_account_binding.dart';
import 'package:social_media_app/modules/auth/bindings/register_binding.dart';
import 'package:social_media_app/modules/auth/views/forgot_password_view.dart';
import 'package:social_media_app/modules/auth/views/login_view.dart';
import 'package:social_media_app/modules/auth/views/reactivate_account_view.dart';
import 'package:social_media_app/modules/auth/views/register_view.dart';
import 'package:social_media_app/modules/auth/views/reset_password_view.dart';
import 'package:social_media_app/modules/block_user/block_user_binding.dart';
import 'package:social_media_app/modules/block_user/block_user_view.dart';
import 'package:social_media_app/modules/chat/bindings/single_chat_binding.dart';
import 'package:social_media_app/modules/chat/views/p2p_chat_settings_view.dart';
import 'package:social_media_app/modules/chat/views/p2p_chat_view.dart';
import 'package:social_media_app/modules/follow_request/follow_request_binding.dart';
import 'package:social_media_app/modules/follow_request/follow_request_view.dart';
import 'package:social_media_app/modules/follower/bindings/followers_list_binding.dart';
import 'package:social_media_app/modules/follower/bindings/following_list_binding.dart';
import 'package:social_media_app/modules/follower/views/followers_list_view.dart';
import 'package:social_media_app/modules/follower/views/following_list_view.dart';
import 'package:social_media_app/modules/home/bindings/initial_binding.dart';
import 'package:social_media_app/modules/home/views/home_view.dart';
import 'package:social_media_app/modules/no_network/no_network_view.dart';
import 'package:social_media_app/modules/post/bindings/create_poll_binding.dart';
import 'package:social_media_app/modules/post/bindings/create_post_binding.dart';
import 'package:social_media_app/modules/post/bindings/post_details_binding.dart';
import 'package:social_media_app/modules/post/bindings/post_liked_users_binding.dart';
import 'package:social_media_app/modules/post/views/create_poll_view.dart';
import 'package:social_media_app/modules/post/views/create_post_view.dart';
import 'package:social_media_app/modules/post/views/poll_preview_view.dart';
import 'package:social_media_app/modules/post/views/post_comment_view.dart';
import 'package:social_media_app/modules/post/views/post_details_view.dart';
import 'package:social_media_app/modules/post/views/post_liked_users_view.dart';
import 'package:social_media_app/modules/post/views/post_preview_view.dart';
import 'package:social_media_app/modules/profile/bindings/edit_about_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_dob_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_gender_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_name_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_profession_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_profile_picture_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_username_binding.dart';
import 'package:social_media_app/modules/profile/bindings/edit_website_binding.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_about_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_dob_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_gender_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_name_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_profession_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_username_view.dart';
import 'package:social_media_app/modules/profile/views/edit_views/edit_website_view.dart';
import 'package:social_media_app/modules/profile/views/profile_details_view.dart';
import 'package:social_media_app/modules/profile/views/profile_view.dart';
import 'package:social_media_app/modules/report/report_binding.dart';
import 'package:social_media_app/modules/report/report_view.dart';
import 'package:social_media_app/modules/server_maintenance/server_maintenance_view.dart';
import 'package:social_media_app/modules/server_offline/server_offline_view.dart';
import 'package:social_media_app/modules/settings/bindings/change_email_binding.dart';
import 'package:social_media_app/modules/settings/bindings/change_password_binding.dart';
import 'package:social_media_app/modules/settings/bindings/change_phone_binding.dart';
import 'package:social_media_app/modules/settings/bindings/deactivate_account_binding.dart';
import 'package:social_media_app/modules/settings/bindings/login_info_binding.dart';
import 'package:social_media_app/modules/settings/bindings/privacy_settings_binding.dart';
import 'package:social_media_app/modules/settings/bindings/report_app_issue_binding.dart';
import 'package:social_media_app/modules/settings/bindings/send_suggestions_binding.dart';
import 'package:social_media_app/modules/settings/views/about_settings_view.dart';
import 'package:social_media_app/modules/settings/views/account_settings_view.dart';
import 'package:social_media_app/modules/settings/views/help_settings_view.dart';
import 'package:social_media_app/modules/settings/views/pages/account/change_email_view.dart';
import 'package:social_media_app/modules/settings/views/pages/account/change_phone_view.dart';
import 'package:social_media_app/modules/settings/views/pages/account/deactivate_account_view.dart';
import 'package:social_media_app/modules/settings/views/pages/account/verified_account_setting_view.dart';
import 'package:social_media_app/modules/settings/views/pages/help/report_app_issue_view.dart';
import 'package:social_media_app/modules/settings/views/pages/help/send_suggestions_view.dart';
import 'package:social_media_app/modules/settings/views/pages/privacy/account_privacy_view.dart';
import 'package:social_media_app/modules/settings/views/pages/privacy/blocked_users_view.dart';
import 'package:social_media_app/modules/settings/views/pages/privacy/mute_block_privacy_settings_view.dart';
import 'package:social_media_app/modules/settings/views/pages/privacy/online_status_view.dart';
import 'package:social_media_app/modules/settings/views/pages/security/change_password_view.dart';
import 'package:social_media_app/modules/settings/views/pages/security/login_info_history_view.dart';
import 'package:social_media_app/modules/settings/views/privacy_settings_view.dart';
import 'package:social_media_app/modules/settings/views/security_settings_view.dart';
import 'package:social_media_app/modules/settings/views/theme_settings_view.dart';
import 'package:social_media_app/modules/user/user_details_binding.dart';
import 'package:social_media_app/modules/user/user_profile_view.dart';
import 'package:social_media_app/modules/verification/verification_binding.dart';
import 'package:social_media_app/modules/verification/verification_view.dart';
import 'package:social_media_app/modules/verify-otp/bindings/verify_otp_binding.dart';
import 'package:social_media_app/modules/verify-otp/views/send_otp_to_email_view.dart';
import 'package:social_media_app/modules/verify-otp/views/send_otp_to_phone_view.dart';
import 'package:social_media_app/modules/verify-otp/views/verify_otp_view.dart';
import 'package:social_media_app/modules/verify_password/verify_password_bindings.dart';
import 'package:social_media_app/modules/verify_password/verify_password_view.dart';
import 'package:social_media_app/modules/welcome/welcome_view.dart';

part 'app_routes.dart';

abstract class AppPages {
  static var defaultTransition = Transition.circularReveal;
  static final pages = [
    GetPage(
      name: _Routes.maintenance,
      page: ServerMaintenanceView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.offline,
      page: ServerOfflineView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.error,
      page: AppErrorView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.noNetwork,
      page: NoNetworkView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

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

    /// Send OTP To Email Page
    GetPage(
      name: _Routes.sendOtpToEmail,
      page: SendOtpToEmailView.new,
      transitionDuration: transitionDuration,
      binding: VerifyOtpBinding(),
      transition: defaultTransition,
    ),

    /// Send OTP To Phone Page
    GetPage(
      name: _Routes.sendOtpToPhone,
      page: SendOtpToPhoneView.new,
      transitionDuration: transitionDuration,
      binding: VerifyOtpBinding(),
      transition: defaultTransition,
    ),

    /// Verify OTP Page
    GetPage(
      name: _Routes.verifyOtp,
      page: VerifyOtpView.new,
      transitionDuration: transitionDuration,
      binding: VerifyOtpBinding(),
      transition: defaultTransition,
    ),

    /// Reactivate Account
    GetPage(
      name: _Routes.reactivateAccount,
      page: ReactivateAccountView.new,
      binding: ReactivateAccountBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// Chats
    GetPage(
      name: _Routes.chatDetails,
      page: P2PChatView.new,
      binding: SingleChatBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.chatSettings,
      page: P2PChatSettingsView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// Profile
    GetPage(
      name: _Routes.profile,
      page: ProfileView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// Block User
    GetPage(
      name: _Routes.blockUser,
      page: BlockUserView.new,
      binding: BlockUserBinding(),
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

    GetPage(
      name: _Routes.editWebsite,
      page: EditWebsiteView.new,
      binding: EditWebsiteBinding(),
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
      name: _Routes.createPoll,
      page: CreatePollView.new,
      transitionDuration: transitionDuration,
      binding: CreatePollBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.pollPreview,
      page: PollPreviewView.new,
      transitionDuration: transitionDuration,
      binding: CreatePollBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.postPreview,
      page: PostPreviewView.new,
      transitionDuration: transitionDuration,
      binding: CreatePostBinding(),
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
      name: _Routes.userProfile,
      page: UserProfileView.new,
      binding: UserProfileBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.followRequests,
      page: FollowRequestView.new,
      binding: FollowRequestBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    ///  Settings Pages --------------------------------------------------------

    GetPage(
      name: _Routes.accountSettings,
      page: AccountSettingsView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.securitySettings,
      page: SecuritySettingsView.new,
      binding: LoginInfoBinding(),
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

    /// HELP SETTINGS -------------------------------------------------------

    GetPage(
      name: _Routes.reportIssueSettings,
      page: ReportAppIssueView.new,
      transitionDuration: transitionDuration,
      binding: ReportAppIssueBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.sendSuggestionsSettings,
      page: SendSuggestionsView.new,
      transitionDuration: transitionDuration,
      binding: SendSuggestionsBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.sendSuggestionsSettings,
      page: SendSuggestionsView.new,
      transitionDuration: transitionDuration,
      binding: SendSuggestionsBinding(),
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    /// ACCOUNT SETTINGS -------------------------------------------------------

    GetPage(
      name: _Routes.changeEmailSettings,
      page: ChangeEmailView.new,
      transitionDuration: transitionDuration,
      binding: ChangeEmailBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.changePhoneSettings,
      page: ChangePhoneView.new,
      transitionDuration: transitionDuration,
      binding: ChangePhoneBinding(),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.blueTickVerificationSettings,
      page: VerifiedAccountSettingView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.blueTickVerification,
      page: VerificationView.new,
      binding: VerificationBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.deactivateAccountSettings,
      page: DeactivateAccountView.new,
      transitionDuration: transitionDuration,
      binding: DeactivateAccountBinding(),
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
      page: LoginInfoHistoryView.new,
      binding: LoginInfoBinding(),
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

    GetPage(
      name: _Routes.onlineStatusSettings,
      page: OnlineStatusView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.muteBlockPrivacySettings,
      page: MuteBlockPrivacySettingsView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.blockedUsersSettings,
      page: BlockedUsersView.new,
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

    /// App Update -------------------------------------------------------------

    GetPage(
      name: _Routes.verifyPassword,
      page: VerifyPasswordView.new,
      binding: VerifyPasswordBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------

    /// Report Issue -----------------------------------------------------------

    GetPage(
      name: _Routes.reportIssueSettings,
      page: ReportAppIssueView.new,
      binding: ReportAppIssueBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.reportIssue,
      page: ReportView.new,
      binding: ReportBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------
  ];

  static var transitionDuration = const Duration(milliseconds: 500);
}

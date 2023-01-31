import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/enums.dart';
import 'package:social_media_app/modules/block_user/block_user_controller.dart';
import 'package:social_media_app/modules/chat/controllers/p2p_chat_controller.dart';
import 'package:social_media_app/modules/follower/controllers/followers_list_controller.dart';
import 'package:social_media_app/modules/follower/controllers/following_list_controller.dart';
import 'package:social_media_app/modules/post/controllers/comment_controller.dart';
import 'package:social_media_app/modules/post/controllers/post_details_controller.dart';
import 'package:social_media_app/modules/report/report_controller.dart';
import 'package:social_media_app/modules/user/user_details_controller.dart';
import 'package:social_media_app/routes/app_pages.dart';

abstract class RouteManagement {
  /// Welcome ------------------------------------------------------------------
  static void goToWelcomeView() {
    Get.offAllNamed(AppRoutes.welcome);
  }

  static void goToServerMaintenanceView() {
    Get.offAllNamed(AppRoutes.maintenance);
  }

  static void goToServerOfflineView() {
    Get.offAllNamed(AppRoutes.offline);
  }

  static void gotToErrorView() {
    Get.offAllNamed(AppRoutes.error);
  }

  static void goToNetworkErrorView() {
    Get.offAllNamed(AppRoutes.noNetwork);
  }

  static void goToHomeView() {
    Get.offAllNamed(AppRoutes.home);
  }

  /// User ---------------------------------------------------------------------

  static void goToBlockUserView(String id, String uname, MediaFile avatar) {
    Get.delete<BlockUserController>();
    Get.toNamed(AppRoutes.blockUser, arguments: {
      'id': id,
      'uname': uname,
      'avatar': avatar,
    });
  }

  static void goToUserProfileDetailsViewByUserId(String userId) {
    Get.delete<UserDetailsController>();
    Get.toNamed(AppRoutes.userProfile, arguments: [userId, 'uid']);
  }

  static void goToUserProfileDetailsViewByUsername(String username) {
    Get.delete<UserDetailsController>();
    Get.toNamed(AppRoutes.userProfile, arguments: [username, 'uname']);
  }

  /// --------------------------------------------------------------------------

  /// Auth ---------------------------------------------------------------------

  static void goToLoginView() {
    Get.toNamed(AppRoutes.login);
  }

  static void goToRegisterView() {
    Get.toNamed(AppRoutes.register);
  }

  static void goToForgotPasswordView() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  static void goToResetPasswordView() {
    Get.toNamed(AppRoutes.resetPassword);
  }

  static void goToSendVerifyAccountOtpView() {
    Get.toNamed(AppRoutes.sendVerifyAccountOtp);
  }

  static void goToVerifyAccountView() {
    Get.toNamed(AppRoutes.verifyAccount);
  }

  static void goToReactivateAccountView() {
    Get.toNamed(AppRoutes.reactivateAccount);
  }

  /// OTP ----------------------------------------------------------------------

  static void goToSendOtpToEmailView({VoidCallback? callback}) {
    Get.toNamed(AppRoutes.sendOtpToEmail, arguments: {'callback': callback});
  }

  static void goToSendOtpToPhoneView({VoidCallback? callback}) {
    Get.toNamed(AppRoutes.sendOtpToPhone, arguments: {'callback': callback});
  }

  static void goToVerifyOtpView() {
    Get.toNamed(AppRoutes.verifyOtp);
  }

  /// --------------------------------------------------------------------------

  static void goToFollowRequestsView() {
    Get.toNamed(AppRoutes.followRequests);
  }

  static void goToChatsView() {
    Get.toNamed(AppRoutes.chats);
  }

  static void goToChatDetailsView(User user) {
    Get.delete<P2PChatController>();
    Get.toNamed(AppRoutes.chatDetails, arguments: [user]);
  }

  static void goToChatSettingsView() {
    Get.toNamed(AppRoutes.chatSettings);
  }

  /// --------------------------------------------------------------------------

  /// Edit Profile -------------------------------------------------------------

  static void goToProfileView() {
    Get.toNamed(AppRoutes.profile);
  }

  static void goToEditProfileView() {
    Get.toNamed(AppRoutes.editProfile);
  }

  static void goToEditNameView() {
    Get.toNamed(AppRoutes.editName);
  }

  static void goToEditUsernameView() {
    Get.toNamed(AppRoutes.editUsername);
  }

  static void goToEditAboutView() {
    Get.toNamed(AppRoutes.editAbout);
  }

  static void goToEditDOBView() {
    Get.toNamed(AppRoutes.editDob);
  }

  static void goToEditGenderView() {
    Get.toNamed(AppRoutes.editGender);
  }

  static void goToEditPhoneView() {
    Get.toNamed(AppRoutes.editPhone);
  }

  static void goToEditProfessionView() {
    Get.toNamed(AppRoutes.editProfession);
  }

  static void goToEditWebsiteView() {
    Get.toNamed(AppRoutes.editWebsite);
  }

  /// --------------------------------------------------------------------------

  /// Post & Comment -----------------------------------------------------------

  static void goToCreatePostView() {
    Get.toNamed(AppRoutes.createPost);
  }

  static void toCreatePollView() {
    Get.toNamed(AppRoutes.createPoll);
  }

  static void goToPollPreviewView() {
    Get.toNamed(AppRoutes.pollPreview);
  }

  static void goToPostPreviewView() {
    Get.toNamed(AppRoutes.postPreview);
  }

  static void goToAddCaptionView() {
    Get.toNamed(AppRoutes.addCaption);
  }

  static void goToPostCommentsView(String postId) {
    Get.toNamed(AppRoutes.comments, arguments: [postId]);
  }

  static void goToPostPostLikedUsersView(String postId) {
    Get.toNamed(AppRoutes.postLikedUsers, arguments: postId);
  }

  static void goToFollowersListView(String userId) {
    Get.delete<FollowersListController>();
    Get.toNamed(AppRoutes.followers, arguments: userId);
  }

  static void goToFollowingListView(String userId) {
    Get.delete<FollowingListController>();
    Get.toNamed(AppRoutes.following, arguments: userId);
  }

  static void goToPostDetailsView(String postId, Post? post) {
    Get.delete<PostDetailsController>();
    Get.delete<CommentController>();
    Get.toNamed(AppRoutes.postDetails, arguments: [postId, post]);
  }

  /// --------------------------------------------------------------------------

  /// Settings Pages -----------------------------------------------------------

  static void goToAccountSettingsView() {
    Get.toNamed(AppRoutes.accountSettings);
  }

  static void goToSecuritySettingsView() {
    Get.toNamed(AppRoutes.securitySettings);
  }

  static void goToPrivacySettingsView() {
    Get.toNamed(AppRoutes.privacySettings);
  }

  static void goToHelpSettingsView() {
    Get.toNamed(AppRoutes.helpSettings);
  }

  static void goToAboutSettingsView() {
    Get.toNamed(AppRoutes.aboutSettings);
  }

  static void goToThemeSettingsView() {
    Get.toNamed(AppRoutes.themeSettings);
  }

  /// --------------------------------------------------------------------------

  /// Account Settings Pages --------------------------------------------------

  static void goToChangeEmailSettingsView() {
    Get.toNamed(AppRoutes.changeEmailSettings);
  }

  static void goToChangePhoneSettingsView() {
    Get.toNamed(AppRoutes.changePhoneSettings);
  }

  static void goToVerificationSettingsView() {
    Get.toNamed(AppRoutes.blueTickVerificationSettings);
  }

  static void goToBlueTickVerificationView() {
    Get.toNamed(AppRoutes.blueTickVerification);
  }

  static void goToDeactivateAccountSettingsView() {
    Get.toNamed(AppRoutes.deactivateAccountSettings);
  }

  /// --------------------------------------------------------------------------

  /// Help Settings Pages ------------------------------------------------------

  static void goToReportIssueSettingsView() {
    Get.toNamed(AppRoutes.reportIssueSettings);
  }

  static void goToSendSuggestionsSettingsView() {
    Get.toNamed(AppRoutes.sendSuggestionsSettings);
  }

  /// --------------------------------------------------------------------------

  /// Security Settings Pages --------------------------------------------------

  static void goToLoginActivityView() {
    Get.toNamed(AppRoutes.loginActivitySettings);
  }

  static void goToChangePasswordView() {
    Get.toNamed(AppRoutes.changePassword);
  }

  /// --------------------------------------------------------------------------

  /// Privacy Settings Pages --------------------------------------------------

  static void goToChangeAccountPrivacyView() {
    Get.toNamed(AppRoutes.accountPrivacySettings);
  }

  static void goToChangeOnlineStatusView() {
    Get.toNamed(AppRoutes.onlineStatusSettings);
  }

  static void goToMuteAndBlockSettingsView() {
    Get.toNamed(AppRoutes.muteBlockPrivacySettings);
  }

  static void goToBlockedUsersSettingsView() {
    Get.toNamed(AppRoutes.blockedUsersSettings);
  }

  /// --------------------------------------------------------------------------

  /// Go to App Update View ----------------------------------------------------

  static void goToAppUpdateView() {
    Get.offAllNamed(AppRoutes.appUpdate);
  }

  /// --------------------------------------------------------------------------

  /// Go to Verify Password View -----------------------------------------------

  static void goToVerifyPasswordView(VoidCallback cb) {
    Get.toNamed(AppRoutes.verifyPassword, arguments: cb);
  }

  /// --------------------------------------------------------------------------

  /// Report Issue -------------------------------------------------------------

  static void goToReportIssueView(String id, ReportType type) {
    Get.delete<ReportController>();
    Get.toNamed(AppRoutes.reportIssue,
        arguments: {'id': id, 'reportType': type});
  }

  /// --------------------------------------------------------------------------

  /// Go to back Page / Close Pages --------------------------------------------

  static void goToBack() {
    Get.back();
  }

  /// --------------------------------------------------------------------------
}

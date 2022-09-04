import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/modules/follower/controllers/followers_list_controller.dart';
import 'package:social_media_app/modules/follower/controllers/following_list_controller.dart';
import 'package:social_media_app/modules/user/user_details_controller.dart';
import 'package:social_media_app/routes/app_pages.dart';

abstract class RouteManagement {
  /// Welcome ------------------------------------------------------------------
  static void goToWelcomeView() {
    Get.offAllNamed(AppRoutes.welcome);
  }

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

  static void goToHomeView() {
    Get.offAllNamed(AppRoutes.home);
  }

  /// --------------------------------------------------------------------------

  /// Edit Profile -------------------------------------------------------------

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

  /// --------------------------------------------------------------------------

  /// Profile & User -----------------------------------------------------------

  static void goToCreatePostView() {
    Get.toNamed(AppRoutes.createPost);
  }

  static void goToAddCaptionView() {
    Get.toNamed(AppRoutes.addCaption);
  }

  static void goToPostCommentsView(String postId) {
    Get.toNamed(AppRoutes.comments, arguments: postId);
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

  static void goToUserProfileView(String userId) {
    Get.delete<UserDetailsController>();
    Get.toNamed("${AppRoutes.userProfile}/$userId", arguments: userId);
  }

  static void goToPostDetailsView(String postId, Post post) {
    Get.toNamed(AppRoutes.postDetails, arguments: [postId, post]);
  }

  /// --------------------------------------------------------------------------

  /// Settings Pages -----------------------------------------------------------

  static void goToSettingsView() {
    Get.toNamed(AppRoutes.settings);
  }

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

  /// Go to App Update View ----------------------------------------------------

  static void goToAppUpdateView() {
    Get.offAllNamed(AppRoutes.appUpdate);
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

  /// --------------------------------------------------------------------------

  /// Go to back Page / Close Pages --------------------------------------------

  static void goToBack() {
    Get.back();
  }

  /// --------------------------------------------------------------------------
}

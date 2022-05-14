import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/modules/profile/controllers/followers_list_controller.dart';
import 'package:social_media_app/modules/profile/controllers/following_list_controller.dart';
import 'package:social_media_app/modules/users/controllers/user_profile_controller.dart';
import 'package:social_media_app/routes/app_pages.dart';

abstract class RouteManagement {
  static void goToLoginView() {
    Get.offAllNamed(AppRoutes.login);
  }

  static void goToSplashView() {
    Get.offAllNamed(AppRoutes.splash);
  }

  static void goToErrorView() {
    Get.offAllNamed(AppRoutes.error);
  }

  static void goToRegisterView() {
    Get.toNamed(AppRoutes.register);
  }

  static void goToForgotPasswordView() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  static void goToResetPasswordView() {
    Get.offAndToNamed(AppRoutes.resetPassword);
  }

  static void goToHomeView() {
    Get.offAllNamed(AppRoutes.home);
  }

  static void goToEditProfileView() {
    Get.toNamed(AppRoutes.editProfile);
  }

  static void goToChangePasswordView() {
    Get.toNamed(AppRoutes.changePassword);
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

  static void goToCreatePostView() {
    Get.toNamed(AppRoutes.createPost);
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
    Get.delete<UserProfileController>();
    Get.toNamed("${AppRoutes.userProfile}/$userId");
  }

  static void goToPostDetailsView(String postId, Post post) {
    Get.toNamed(AppRoutes.postDetails, arguments: [postId, post]);
  }

  // SETTINGS

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

  static void goToBack() {
    Get.back();
  }
}

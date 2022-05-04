import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
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

  static void goToSettingsView() {
    Get.toNamed(AppRoutes.settings);
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

  static void goToFollowersListView() {
    Get.toNamed(AppRoutes.followers);
  }

  static void goToFollowingListView() {
    Get.toNamed(AppRoutes.following);
  }

  static void goToUserProfileView(String userId) {
    Get.toNamed(AppRoutes.userProfile, arguments: userId);
  }

  static void goToPostDetailsView(String postId, Post post) {
    Get.toNamed(AppRoutes.postDetails, arguments: [postId, post]);
  }

  static void goToBack() {
    Get.back();
  }
}

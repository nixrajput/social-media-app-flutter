import 'package:get/get.dart';
import 'package:social_media_app/routes/app_pages.dart';

abstract class RouteManagement {
  static void goToHomeView() {
    Get.offAllNamed(AppRoutes.home);
  }

  static void goToSettingsView() {
    Get.toNamed(AppRoutes.settings);
  }
}

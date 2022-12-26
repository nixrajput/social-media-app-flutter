import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/banner_controller.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/controllers/recommended_user_controller.dart';
import 'package:social_media_app/modules/home/controllers/tab_controller.dart';
import 'package:social_media_app/modules/home/controllers/trending_post_controller.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profile_picture_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new, fenix: true);
    Get.lazyPut(TrendingTabController.new);
    Get.lazyPut(TrendingPostController.new, fenix: true);
    Get.lazyPut(RecommendedUsersController.new, fenix: true);
    Get.lazyPut(EditProfilePictureController.new, fenix: true);
    Get.lazyPut(BannerController.new, fenix: true);
  }
}

import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/recommended_user_controller.dart';
import 'package:social_media_app/modules/home/controllers/tab_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profile_picture_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new);
    Get.lazyPut(PostController.new, fenix: true);
    Get.lazyPut(CreatePostController.new);
    Get.lazyPut(TrendingTabController.new);
    Get.lazyPut(RecommendedUsersController.new, fenix: true);
    Get.lazyPut(NotificationController.new, fenix: true);
    Get.lazyPut(EditProfilePictureController.new, fenix: true);
  }
}

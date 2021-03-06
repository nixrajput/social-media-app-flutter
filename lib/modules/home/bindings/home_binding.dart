import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_like_controller.dart';
import 'package:social_media_app/modules/home/controllers/tab_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';
import 'package:social_media_app/modules/users/controllers/user_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new);
    Get.lazyPut(PostController.new, fenix: true);
    Get.lazyPut(PostLikeController.new, fenix: true);
    Get.lazyPut(CreatePostController.new);
    Get.lazyPut(TrendingTabController.new);
    Get.lazyPut(UserController.new, fenix: true);
    Get.lazyPut(NotificationController.new);
  }
}

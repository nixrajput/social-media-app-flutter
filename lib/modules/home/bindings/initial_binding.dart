import 'package:get/get.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';
import 'package:social_media_app/modules/home/controllers/banner_controller.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/recommended_user_controller.dart';
import 'package:social_media_app/modules/home/controllers/tab_controller.dart';
import 'package:social_media_app/modules/home/controllers/trending_post_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profile_picture_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new, fenix: true);
    Get.lazyPut(ChatController.new, fenix: true);
    Get.lazyPut(PostController.new, fenix: true);
    Get.put(CreatePostController(), permanent: true);
    Get.lazyPut(TrendingTabController.new);
    Get.lazyPut(FollowRequestController.new, fenix: true);
    Get.lazyPut(TrendingPostController.new, fenix: true);
    Get.lazyPut(RecommendedUsersController.new, fenix: true);
    Get.lazyPut(NotificationController.new, fenix: true);
    Get.lazyPut(EditProfilePictureController.new, fenix: true);
    Get.lazyPut(BannerController.new, fenix: true);
  }
}

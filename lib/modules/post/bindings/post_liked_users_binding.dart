import 'package:get/get.dart';
import 'package:social_media_app/modules/post/controllers/post_liked_users_controller.dart';

class PostLikedUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PostLikedUsersController.new);
  }
}

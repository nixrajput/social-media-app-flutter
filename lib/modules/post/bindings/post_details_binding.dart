import 'package:get/get.dart';
import 'package:social_media_app/modules/post/controllers/comment_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_comment_controller.dart';

class PostDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CommentController.new);
    Get.lazyPut(CreateCommentController.new);
  }
}

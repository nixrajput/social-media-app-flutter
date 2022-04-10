import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/comments_controller.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CommentsController.new);
  }
}

import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/post_details_controller.dart';

class PostDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PostDetailsController.new);
  }
}

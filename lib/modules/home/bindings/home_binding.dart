import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/navbar_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(NavBarController.new);
    Get.lazyPut(PostController.new);
  }
}

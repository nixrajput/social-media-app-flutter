import 'package:get/get.dart';
import 'package:social_media_app/modules/user/controllers/about_controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AboutController.new);
  }
}

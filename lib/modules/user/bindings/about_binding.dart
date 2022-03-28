import 'package:get/get.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/modules/user/controllers/about_controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AuthController.new);
    Get.lazyPut(AboutController.new);
  }
}

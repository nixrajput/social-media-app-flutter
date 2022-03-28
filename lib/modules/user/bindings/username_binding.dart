import 'package:get/get.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/modules/user/controllers/username_controller.dart';

class UsernameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AuthController.new);
    Get.lazyPut(UsernameController.new);
  }
}

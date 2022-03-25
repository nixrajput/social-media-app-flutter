import 'package:get/get.dart';
import 'package:social_media_app/modules/auth/controllers/auth_controller.dart';
import 'package:social_media_app/modules/user/controllers/user_controller.dart';

class UsernameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AuthController.new);
    Get.lazyPut(UserController.new);
  }
}

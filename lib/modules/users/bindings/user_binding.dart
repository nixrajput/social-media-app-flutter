import 'package:get/get.dart';
import 'package:social_media_app/modules/users/controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserController.new);
  }
}

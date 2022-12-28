import 'package:get/get.dart';
import 'package:social_media_app/modules/auth/controllers/password_controller.dart';

class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PasswordController.new);
  }
}

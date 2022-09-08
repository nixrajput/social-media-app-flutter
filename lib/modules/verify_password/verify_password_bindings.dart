import 'package:get/get.dart';
import 'package:social_media_app/modules/verify_password/verify_password_controller.dart';

class VerifyPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(VerifyPasswordController.new);
  }
}

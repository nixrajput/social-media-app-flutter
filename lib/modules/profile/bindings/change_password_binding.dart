import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChangePasswordController.new);
  }
}

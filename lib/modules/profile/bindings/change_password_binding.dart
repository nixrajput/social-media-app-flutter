import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChangePasswordController.new);
  }
}

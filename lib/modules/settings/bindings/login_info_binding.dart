import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/login_info_controller.dart';

class LoginInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LoginInfoController.new);
  }
}

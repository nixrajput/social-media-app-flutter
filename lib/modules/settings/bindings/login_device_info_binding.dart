import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/login_device_info_controller.dart';

class LoginDeviceInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LoginDeviceInfoController.new);
  }
}

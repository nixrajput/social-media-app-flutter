import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/security_settings_controller.dart';

class SecuritySettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SecuritySettingsController.new);
  }
}

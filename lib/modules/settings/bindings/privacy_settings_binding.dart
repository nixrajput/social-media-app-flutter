import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/account_type_controller.dart';

class PrivacySettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AccountTypeController.new);
  }
}

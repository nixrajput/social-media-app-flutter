import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/deactivate_account_controller.dart';

class DeactivateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(DeactivateAccountController.new);
  }
}

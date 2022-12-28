import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/change_phone_controller.dart';

class ChangePhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChangePhoneController.new);
  }
}

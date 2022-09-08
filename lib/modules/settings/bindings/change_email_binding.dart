import 'package:get/get.dart';
import 'package:social_media_app/modules/settings/controllers/change_email_controller.dart';

class ChangeEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChangeEmailController.new);
  }
}

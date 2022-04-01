import 'package:get/get.dart';
import 'package:social_media_app/modules/user/controllers/edit_dob_controller.dart';

class DOBBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(DOBController.new);
  }
}

import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/edit_dob_controller.dart';

class EditDOBBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditDOBController.new);
  }
}

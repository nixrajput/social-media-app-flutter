import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/edit_name_controller.dart';

class EditNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditNameController.new);
  }
}

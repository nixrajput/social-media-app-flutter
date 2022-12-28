import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/edit_username_controller.dart';

class EditUsernameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditUsernameController.new);
  }
}

import 'package:get/get.dart';
import 'package:social_media_app/modules/user/controllers/edit_profile_picture_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditProfilePictureController.new);
  }
}

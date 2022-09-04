import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/edit_gender_controller.dart';

class EditGenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditGenderController.new);
  }
}

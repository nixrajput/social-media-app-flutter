import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profession_controller.dart';

class EditProfessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditProfessionController.new);
  }
}

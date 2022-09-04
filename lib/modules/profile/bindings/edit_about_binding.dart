import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/edit_about_controller.dart';

class EditAboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditAboutController.new);
  }
}

import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/edit_website_controller.dart';

class EditWebsiteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditWebsiteController.new);
  }
}

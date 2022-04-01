import 'package:get/get.dart';
import 'package:social_media_app/modules/user/controllers/edit_gender_controller.dart';

class GenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(GenderController.new);
  }
}

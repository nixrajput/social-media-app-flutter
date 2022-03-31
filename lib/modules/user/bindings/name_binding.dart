import 'package:get/get.dart';
import 'package:social_media_app/modules/user/controllers/edit_name_controller.dart';

class NameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(NameController.new);
  }
}

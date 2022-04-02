import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/edit_username_controller.dart';

class UsernameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UsernameController.new);
  }
}

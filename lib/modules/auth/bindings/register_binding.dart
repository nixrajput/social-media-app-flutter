import 'package:get/get.dart';
import 'package:social_media_app/modules/auth/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(RegisterController.new);
  }
}

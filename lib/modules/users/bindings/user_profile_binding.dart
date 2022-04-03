import 'package:get/get.dart';
import 'package:social_media_app/modules/users/controllers/user_profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserProfileController.new);
  }
}

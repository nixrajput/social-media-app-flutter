import 'package:get/get.dart';
import 'package:social_media_app/modules/user/user_details_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserDetailsController.new);
  }
}

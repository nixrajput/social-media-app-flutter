import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/following_list_controller.dart';

class FollowingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(FollowingListController.new);
  }
}

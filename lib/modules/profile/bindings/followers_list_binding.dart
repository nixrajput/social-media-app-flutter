import 'package:get/get.dart';
import 'package:social_media_app/modules/profile/controllers/followers_list_controller.dart';

class FollowersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(FollowersListController.new);
  }
}

import 'package:get/get.dart';
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';

class FollowRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(FollowRequestController.new);
  }
}

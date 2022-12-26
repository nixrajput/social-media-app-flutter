import 'package:get/get.dart';
import 'package:social_media_app/modules/post/controllers/create_poll_controller.dart';

class CreatePollBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CreatePollController.new);
  }
}

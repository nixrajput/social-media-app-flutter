import 'package:get/get.dart';
import 'package:social_media_app/modules/chat/controllers/single_chat_controller.dart';

class SingleChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SingleChatController.new);
  }
}

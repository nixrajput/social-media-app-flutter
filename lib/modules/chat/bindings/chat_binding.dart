import 'package:get/get.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/chat/controllers/single_chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChatController.new);
    Get.lazyPut(SingleChatController.new);
  }
}

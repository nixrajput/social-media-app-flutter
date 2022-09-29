import 'dart:convert';

import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class SingleChatController extends GetxController {
  static SingleChatController get find => Get.find();

  final chatController = ChatController.find;
  final profile = ProfileController.find;

  final messageTextController = material.TextEditingController();

  final _isLoading = false.obs;
  final _message = ''.obs;

  bool get isLoading => _isLoading.value;

  String get message => _message.value;

  String? receiverId;
  String? receiverUname;

  void onChangedText(value) {
    _message.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    receiverId = Get.arguments[0];
    receiverUname = Get.arguments[1];
    if (receiverId != null) {
      chatController.channel.sink.add(
        jsonEncode(
          {
            "type": "get-message-by-id",
            "payload": {
              "userId": receiverId,
              "limit": 1,
            }
          },
        ),
      );
    }
  }

  void loadMoreMessages(int currentPage) async {
    chatController.channel.sink.add(
      jsonEncode(
        {
          "type": "get-message-by-id",
          "payload": {
            "userId": receiverId,
            "limit": 1,
            "page": currentPage + 1,
          }
        },
      ),
    );
  }

  void sendMessage() async {
    material.FocusManager.instance.primaryFocus!.unfocus();

    messageTextController.clear();
    var encryptedMessage = base64Encode(message.codeUnits);
    AppUtility.printLog('Encrypted message: $encryptedMessage');
    chatController.channel.sink.add(
      jsonEncode(
        {
          "type": "send-message",
          "payload": {
            "message": encryptedMessage,
            "type": "text",
            "receiverId": receiverId,
          }
        },
      ),
    );
    _message.value = '';
    update();
  }
}

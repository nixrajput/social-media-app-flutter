import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/responses/chat_message_list_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class SingleChatController extends GetxController {
  static SingleChatController get find => Get.find();

  final chatController = ChatController.find;
  final profile = ProfileController.find;

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final messageTextController = material.TextEditingController();
  final scrollController = material.ScrollController();

  final _isLoading = false.obs;
  final _scrolledToBottom = true.obs;
  final _isMoreLoading = false.obs;
  final _message = ''.obs;
  final _messageData = const ChatMessageListResponse().obs;
  final _pickedFileList = RxList<File>();

  bool get isLoading => _isLoading.value;
  bool get isMoreLoading => _isMoreLoading.value;
  bool get scrolledToBottom => _scrolledToBottom.value;
  String get message => _message.value;
  List<File>? get pickedFileList => _pickedFileList;

  ChatMessageListResponse? get messageData => _messageData.value;

  /// Setters
  set setMessageData(ChatMessageListResponse response) =>
      _messageData.value = response;

  String? userId;
  String? username;

  void onChangedText(value) {
    _message.value = value;
    update();
  }

  void scrollToLast() {
    material.WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: material.Curves.easeOut,
      );
    });
  }

  void scrollToFirst() {
    material.WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: material.Curves.easeOut,
      );
    });
  }

  void sendMessage() async {
    material.FocusManager.instance.primaryFocus!.unfocus();

    messageTextController.clear();
    var encryptedMessage = base64Encode(utf8.encode(message));
    AppUtility.printLog('Encrypted message: $encryptedMessage');

    var tempId = AppUtility.generateUid(10);

    var tempMessage = ChatMessage(
      tempId: tempId,
      senderId: profile.profileDetails!.user!.id,
      receiverId: userId!,
      message: encryptedMessage,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      seen: false,
      sender: null,
      receiver: null,
    );

    chatController.addTempMessage(tempMessage);

    chatController.channel.sink.add(
      jsonEncode(
        {
          "type": "send-message",
          "payload": {
            "message": encryptedMessage,
            "type": "text",
            "receiverId": userId,
            "tempId": tempId,
            // "mediaFiles": [],
            // "replyTo": "",
          }
        },
      ),
    );
    _message.value = '';
    update();
    scrollToLast();
  }

  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments[0];
    username = Get.arguments[1];
    if (userId != null) {
      _getData();
    }
    material.WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.minScrollExtent + (2 * Dimens.hundred)) {
          _scrolledToBottom.value = false;
          update();
        } else {
          _scrolledToBottom.value = true;
          update();
        }
      });
    });
  }

  _getData() async {
    await _fetchMessagesById();
    _markMessageAsRead();
  }

  void _markMessageAsRead() async {
    if (chatController.allMessages.isNotEmpty) {
      var unreadMessages = chatController.allMessages
          .where((element) =>
              (element.senderId == userId &&
                  element.receiverId == profile.profileDetails!.user!.id) &&
              element.seen == false)
          .toList();
      if (unreadMessages.isNotEmpty) {
        AppUtility.printLog('Marking message as read');
        for (var message in unreadMessages) {
          chatController.channel.sink.add(
            jsonEncode(
              {
                "type": "message-read",
                "payload": {
                  "messageId": message.id,
                  "senderId": message.sender!.id,
                }
              },
            ),
          );
          message.seen = true;
          message.seenAt = DateTime.now();
          update();
        }
      }
    }
  }

  Future<void> _fetchMessagesById() async {
    AppUtility.printLog("Fetching Messages Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getMessagesById(_auth.token, userId!);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog("Fetching Messages Success");
        setMessageData = ChatMessageListResponse.fromJson(decodedData);

        for (var element in messageData!.results!) {
          chatController.addToAllMessages(element);
        }

        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtility.printLog("Fetching Messages Error");
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtility.printLog("Fetching More Last Messages Request");
    _isMoreLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getMessagesById(_auth.token, userId!, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setMessageData = ChatMessageListResponse.fromJson(decodedData);

        for (var element in messageData!.results!) {
          chatController.addToAllMessages(element);
        }

        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Messages Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching Last Messages Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchLatestMessages() async => await _fetchMessagesById();

  Future<void> loadMore() async =>
      await _loadMore(page: _messageData.value.currentPage! + 1);

  void markMessageAsRead() => _markMessageAsRead();
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/responses/chat_message_list_response.dart';
import 'package:social_media_app/apis/models/responses/chat_message_response.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/utils/utility.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends GetxController {
  static ChatController get find => Get.find();

  final _auth = AuthService.find;

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  late final WebSocketChannel _channel;
  final _chatListData = const ChatMessageListResponse().obs;
  final List<ChatMessage> _chats = [];

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  ChatMessageListResponse? get chatListData => _chatListData.value;

  List<ChatMessage> get chats => _chats;

  @override
  void onInit() {
    super.onInit();
    _initChannel().then((_) {
      _savePublicKey();
    });
  }

  @override
  void onClose() {
    _channel.sink.close();
    super.onClose();
  }

  Future<void> _initChannel() async {
    _channel = WebSocketChannel.connect(
        Uri.parse('${AppSecrets.awsWebSocketUrl}?token=${_auth.token}'));
    _channel.stream.listen((value) {
      var decodedData = jsonDecode(value);
      // AppUtility.printLog(decodedData);
      // AppUtility.printLog(decodedData['data'] is List);

      if (decodedData['results'] != null) {
        _chatListData.value = ChatMessageListResponse.fromJson(decodedData);
        _chats.addAll(_chatListData.value.results!);
        update();
        AppUtility.printLog("Chat List Added");
      }
      if (decodedData['data'] != null) {
        var chatResponse = ChatMessageResponse.fromJson(decodedData);
        _chats.insert(0, chatResponse.data!);
        update();
        AppUtility.printLog("Chat Added");
      }
    }, onError: (err) {
      AppUtility.printLog(err);
    });
  }

  _savePublicKey() async {
    // await AppE2EE().generateKeys();
    // var publicKeyJwk = await AppE2EE().publicKey!.exportJsonWebKey();
    // _channel.sink.add(
    //   jsonEncode(
    //     {
    //       'type': 'save-public-key',
    //       'payload': {
    //         'publicKey': jsonEncode(publicKeyJwk),
    //       }
    //     },
    //   ),
    // );
    // AppUtility.printLog("Public key saved to server");
    _channel.sink.add(
      jsonEncode(
        {
          'type': 'get-all-messages',
          'payload': {
            'limit': 10,
          }
        },
      ),
    );
  }

  Future<void> _fetchMessages({int? page}) async {
    AppUtility.printLog("Fetching Messages Request");

    try {
      _channel.sink.add(
        jsonEncode(
          {
            'type': 'get-all-messages',
            'payload': {
              'page': page,
              'limit': 10,
            }
          },
        ),
      );
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Messages Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Messages Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Messages Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Messages Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _sendMessage(String message, String receiverId) async {
    AppUtility.printLog("Send Message Request");
    try {
      _channel.sink.add(
        jsonEncode(
          {
            'type': 'send-message',
            "payload": {
              "message": message,
              "type": "text",
              "receiverId": receiverId
            },
          },
        ),
      );
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Message Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Message Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Message Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Message Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchPosts() async => await _fetchMessages();

  void sendMessage(String message, String receiverId) async =>
      await _sendMessage(message, receiverId);
}

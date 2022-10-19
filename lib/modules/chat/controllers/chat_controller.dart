import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/online_user.dart';
import 'package:social_media_app/apis/models/responses/chat_message_list_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/providers/socket_api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

class ChatController extends GetxController {
  static ChatController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());
  final _hiveService = HiveService();
  final profile = ProfileController.find;
  final SocketApiProvider _socketApiProvider = SocketApiProvider();

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _lastMessageData = const ChatMessageListResponse().obs;

  // late SignalProtocolManager signalProtocolManager;
  final List<ChatMessage> _lastMessageList = [];
  final List<ChatMessage> _allMessages = [];
  final List<OnlineUser> _onlineUsers = [];
  final List<String> _typingUsers = [];

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  ChatMessageListResponse? get lastMessageData => _lastMessageData.value;

  List<ChatMessage> get lastMessageList => _lastMessageList;

  List<ChatMessage> get allMessages => _allMessages;

  List<OnlineUser> get onlineUsers => _onlineUsers;

  List<String> get typingUsers => _typingUsers;

  /// Setters
  set setLastMessageData(ChatMessageListResponse response) =>
      _lastMessageData.value = response;

  void initialize() async {
    _socketApiProvider.socketEventStream.listen(_addSocketEventListener);
    await _getLastMessages();
    _getUndeliveredMessages();
    _checkOnlineUsers();
  }

  void _getUndeliveredMessages() {
    _socketApiProvider.sendJson({
      'type': 'get-undelivered-messages',
    });
  }

  void _checkOnlineUsers() {
    var userIds = _lastMessageList
        .map((e) => e.senderId == profile.profileDetails!.user!.id
            ? e.receiverId
            : e.senderId)
        .toList();

    _socketApiProvider.sendJson({
      'type': 'check-online-users',
      'payload': {
        'userIds': userIds,
      },
    });
  }

  void _addSocketEventListener(dynamic event) {
    var decodedData = jsonDecode(event);

    var type = decodedData['type'];
    AppUtility.printLog("Socket Event Type: $type");

    switch (type) {
      case 'connection':
        AppUtility.printLog("Socket Connected");
        break;

      case 'message':
        var chatMessage = ChatMessage.fromJson(decodedData['data']);
        _addMessageListener(chatMessage);
        break;

      case 'onlineStatus':
        var onlineUser = OnlineUser.fromJson(decodedData['data']);
        _addOnlineUserListener(onlineUser);
        break;

      case 'messageDelete':
        var messageId = decodedData['messageId'];
        _deleteMessageListener(messageId);
        break;

      case 'messageTyping':
        var userId = decodedData['data']['senderId'];
        var isTyping = decodedData['data']['status'];
        _addTypingIndicatorListener(userId, isTyping);
        break;

      case 'error':
        AppUtility.printLog("Error: ${decodedData['message']}");
        AppUtility.showSnackBar(decodedData['message'], StringValues.error);
        break;

      default:
        AppUtility.printLog("Invalid event type: $type");
        break;
    }
  }

  void _addTypingIndicatorListener(String userId, String status) {
    if (status == 'start') {
      _typingUsers.add(userId);
    } else {
      _typingUsers.remove(userId);
    }
    update();
  }

  void _addOnlineUserListener(OnlineUser onlineUser) {
    var status = onlineUser.status!;

    switch (status) {
      case 'online':
        _onlineUsers.add(onlineUser);
        update();
        break;

      case 'offline':
        _onlineUsers
            .removeWhere((element) => element.userId == onlineUser.userId);
        update();
        break;

      default:
        AppUtility.printLog("Invalid status: $status");
        break;
    }

    AppUtility.printLog('Online Users: ${_onlineUsers.length}');
  }

  void _addMessageListener(ChatMessage encryptedMessage) {
    if (!_checkIfSameMessageInAllMessages(encryptedMessage)) {
      _allMessages.add(encryptedMessage);
      update();
    } else {
      var tempIndex = _allMessages.indexWhere(
        (element) =>
            element.tempId == encryptedMessage.tempId ||
            element.id == encryptedMessage.id,
      );
      var tempMessage = _allMessages[tempIndex];
      var updatedMessage = tempMessage.copyWith(
        id: encryptedMessage.id,
        sender: encryptedMessage.sender,
        receiver: encryptedMessage.receiver,
        replyTo: encryptedMessage.replyTo,
        sent: encryptedMessage.sent,
        sentAt: encryptedMessage.sentAt,
        delivered: encryptedMessage.delivered,
        deliveredAt: encryptedMessage.deliveredAt,
        seen: encryptedMessage.seen,
        seenAt: encryptedMessage.seenAt,
      );
      _allMessages[tempIndex] = updatedMessage;
      update();
    }

    if (!_checkIfSameMessageInLastMessages(encryptedMessage)) {
      var index = _checkIfAlreadyPresentInLastMessages(encryptedMessage);
      if (index < 0) {
        _lastMessageList.add(encryptedMessage);
      } else {
        var oldMessage = _lastMessageList.elementAt(index);
        var isAfter =
            _checkIfLatestChatInLastMessages(oldMessage, encryptedMessage);
        if (isAfter) {
          _lastMessageList.remove(oldMessage);
          _lastMessageList.add(encryptedMessage);
        }
      }
      update();
    } else {
      var tempIndex = _lastMessageList.indexWhere(
        (element) =>
            element.tempId == encryptedMessage.tempId ||
            element.id == encryptedMessage.id,
      );
      var tempMessage = _lastMessageList[tempIndex];
      var updatedMessage = tempMessage.copyWith(
        id: encryptedMessage.id,
        sender: encryptedMessage.sender,
        receiver: encryptedMessage.receiver,
        replyTo: encryptedMessage.replyTo,
        sent: encryptedMessage.sent,
        sentAt: encryptedMessage.sentAt,
        delivered: encryptedMessage.delivered,
        deliveredAt: encryptedMessage.deliveredAt,
        seen: encryptedMessage.seen,
        seenAt: encryptedMessage.seenAt,
      );
      _lastMessageList[tempIndex] = updatedMessage;
      update();
    }
    AppUtility.printLog("Chat Message Added");
  }

  void _deleteMessageListener(String messageId) {
    var indexInAllMessages =
        _allMessages.indexWhere((element) => element.id == messageId);

    var indexInLastMessages =
        _lastMessageList.indexWhere((element) => element.id == messageId);

    if (indexInAllMessages >= 0) {
      _allMessages.removeAt(indexInAllMessages);
    }

    if (indexInLastMessages >= 0) {
      _lastMessageList.removeAt(indexInLastMessages);
    }

    update();
    AppUtility.printLog("Chat Message Deleted");
  }

  void addTempMessage(ChatMessage message) {
    _allMessages.add(message);
    update();
  }

  //message-typing

  // void deleteMultipleMessages(List<String> messageIds) {
  //   _socketApiProvider.sendJson({
  //     'type': 'delete-messages',
  //     'payload': {
  //       'messageIds': messageIds,
  //     }
  //   });
  // }

  // void deleteMessage(String messageId) {
  //   _socketApiProvider.sendJson({
  //     'type': 'delete-message',
  //     'payload': {
  //       'messageId': messageId,
  //     }
  //   });
  // }

  // var secretKeys = await _e2eeService.getSecretKeys();
  // var regId = int.parse(
  //   String.fromCharCodes(base64Decode(secretKeys.registrationId)),
  // );
  // var identityKeyPairString = secretKeys.identityKeyPair;
  // var decodedIdentityKeyPair = base64Decode(identityKeyPairString);
  // var identityKeyPair =
  //     IdentityKeyPair.fromSerialized(decodedIdentityKeyPair);
  // var protocolStore = NxSignalProtocolStore(identityKeyPair, regId);
  // var preKeys = secretKeys.preKeys;
  // var serializedPreKeys = <PreKeyRecord>[];
  // for (var item in preKeys) {
  //   var decodedPreKey = base64Decode(item);
  //   var preKey = PreKeyRecord.fromBuffer(decodedPreKey);
  //   serializedPreKeys.add(preKey);
  // }
  // var signedPreKeyString = secretKeys.signedPreKey;
  // var decodedSignedPreKey = base64Decode(signedPreKeyString);
  // var signedPreKey = SignedPreKeyRecord.fromSerialized(decodedSignedPreKey);
  //
  // for (var item in serializedPreKeys) {
  //   await protocolStore.storePreKey(item.id, item);
  // }
  // await protocolStore.storeSignedPreKey(
  //   signedPreKey.id,
  //   signedPreKey,
  // );
  //

  bool isUserTyping(String userId) {
    return _typingUsers.contains(userId);
  }

  bool isUserOnline(String userId) {
    var user = _onlineUsers.any(
      (element) => element.userId == userId,
    );
    return user;
  }

  void addToAllMessages(ChatMessage message) async {
    if (_checkIfSameMessageInAllMessages(message)) {
      return;
    }
    _allMessages.add(message);
    update();
    // await _hiveService.addBox('lastMessage', jsonEncode(_lastMessageData));
  }

  bool checkIfYourMessage(ChatMessage message) {
    var yourId = profile.profileDetails!.user!.id;

    if (message.senderId == yourId) {
      return true;
    }

    return false;
  }

  bool _checkIfSameMessageInLastMessages(ChatMessage message) {
    var item = _lastMessageList.any((element) =>
        element.id == message.id ||
        (element.tempId != null &&
            message.tempId != null &&
            element.tempId == message.tempId));

    if (item) return true;

    return false;
  }

  bool _checkIfSameMessageInAllMessages(ChatMessage message) {
    var item = _allMessages.any((element) =>
        element.id == message.id ||
        (element.tempId != null &&
            message.tempId != null &&
            element.tempId == message.tempId));

    if (item) return true;

    return false;
  }

  int _checkIfAlreadyPresentInLastMessages(ChatMessage message) {
    var item = _lastMessageList.any((element) =>
        (element.senderId == message.senderId &&
            element.receiverId == message.receiverId) ||
        (element.senderId == message.receiverId &&
            element.receiverId == message.senderId));

    if (item) {
      var index = _lastMessageList.indexWhere((element) =>
          (element.senderId == message.senderId &&
              element.receiverId == message.receiverId) ||
          (element.senderId == message.receiverId &&
              element.receiverId == message.senderId));
      return index;
    }
    return -1;
  }

  bool _checkIfLatestChatInLastMessages(
      ChatMessage oldMessage, ChatMessage newMessage) {
    var isAfter = newMessage.createdAt!.isAfter(oldMessage.createdAt!);
    if (isAfter) return true;
    return false;
  }

  _getLastMessages() async {
    var isExists = await _hiveService.isExists(boxName: 'lastMessage');

    if (isExists) {
      // await _hiveService.clearBox('lastMessage');

      // var data = await _hiveService.getBox('lastMessage');
      // var cachedData = jsonDecode(data);
      // setLastMessageData = ChatMessageListResponse.fromJson(cachedData);
      // _lastMessageList.clear();
      // _lastMessageList.addAll(_lastMessageData.value.results!);
      // _allMessages.clear();
      // _allMessages.addAll(_lastMessageData.value.results!);
    }
    update();

    await _fetchLastMessages();
  }

  Future<void> _fetchLastMessages() async {
    AppUtility.printLog("Fetching Last Messages Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getAllLastMessages(_auth.token);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog("Fetching Last Messages Success");
        setLastMessageData = ChatMessageListResponse.fromJson(decodedData);
        _lastMessageList.clear();
        _lastMessageList.addAll(_lastMessageData.value.results!);
        _allMessages.clear();
        _allMessages.addAll(_lastMessageData.value.results!);
        await _hiveService.addBox('lastMessage', jsonEncode(decodedData));
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtility.printLog("Fetching Last Messages Error");
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
          await _apiProvider.getAllLastMessages(_auth.token, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setLastMessageData = ChatMessageListResponse.fromJson(decodedData);
        _lastMessageList.addAll(_lastMessageData.value.results!);
        _allMessages.addAll(_lastMessageData.value.results!);
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Last Messages Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Last Messages Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Last Messages Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Last Messages Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Last Messages Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Last Messages Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchLastMessages() async => await _fetchLastMessages();

  Future<void> loadMore() async =>
      await _loadMore(page: _lastMessageData.value.currentPage! + 1);
}

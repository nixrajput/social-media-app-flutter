import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/online_user.dart';
import 'package:social_media_app/apis/models/responses/chat_message_list_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/providers/socket_api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/app_services/network_controller.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

const String _kLastMessagesKey = 'lastMessages';
// const String _kOnlineUsersKey = 'onlineUsers';
// const String _kTypingUsersKey = 'typingUsers';
const String _kChatDataKey = 'chatData';

class ChatController extends GetxController {
  static ChatController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());
  final profile = ProfileController.find;
  final socketApiProvider = SocketApiProvider();
  final networkController = NetworkController.instance;

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _lastMessageData = const ChatMessageListResponse().obs;

  // late SignalProtocolManager signalProtocolManager;
  final List<ChatMessage> _lastMessageList = [];
  final List<OnlineUser> _onlineUsers = [];
  final List<String> _typingUsers = [];

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  ChatMessageListResponse? get lastMessageData => _lastMessageData.value;

  List<ChatMessage> get lastMessageList => _lastMessageList;

  List<OnlineUser> get onlineUsers => _onlineUsers;

  List<String> get typingUsers => _typingUsers;

  StreamSubscription<dynamic>? _socketSubscription;

  /// Setters
  set setLastMessageData(ChatMessageListResponse response) =>
      _lastMessageData.value = response;

  /// Methods ------------------------------------------------------------------
  /// --------------------------------------------------------------------------

  Future<void> _loadLocalMessages() async {
    var isExists = await HiveService.hasLength<ChatMessage>(_kLastMessagesKey);

    if (isExists) {
      // await HiveService.deleteBox<ChatMessage>(_kLastMessagesKey);
      var data = await HiveService.getAll<ChatMessage>(_kLastMessagesKey);
      _lastMessageList.clear();
      for (var i = 0; i < data.length; i++) {
        await addMessageToLastMessagesList(data[i]);
      }
    }
  }

  Future<void> initialize() async {
    AppUtility.log("ChatController initializing");
    if (socketApiProvider.isConnected) {
      _socketSubscription ??=
          socketApiProvider.socketEventStream!.listen(_addSocketEventListener);
    }

    networkController.connectionStatus.listen((status) async {
      if (status == true) {
        if (!socketApiProvider.isConnected) {
          await socketApiProvider.init();
          _socketSubscription ??= socketApiProvider.socketEventStream!
              .listen(_addSocketEventListener);
        } else {
          _socketSubscription ??= socketApiProvider.socketEventStream!
              .listen(_addSocketEventListener);
        }
      } else {
        await _socketSubscription?.cancel();
        _socketSubscription = null;
      }
    });

    // Hive.box<ChatMessage>(_kLastMessagesKey).watch().listen((event) async {
    //   if (event.deleted) {
    //     _lastMessageList.removeWhere((element) => element.id == event.key);
    //     _lastMessageList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    //     update();
    //   } else {
    //     var message = event.value;

    //     await addMessageToLastMessagesList(message);
    //   }
    // });

    await _fetchLastMessages();
    _getUndeliveredMessages();
    _checkOnlineUsers();
    AppUtility.log("ChatController initialized");
  }

  Future<void> close() async {
    await _socketSubscription?.cancel();
    _socketSubscription = null;
    _lastMessageList.clear();
    _onlineUsers.clear();
    _typingUsers.clear();
    update();
    AppUtility.log("ChatController closed");
  }

  void _getUndeliveredMessages() {
    AppUtility.log('Get Undelivered Messages');
    socketApiProvider.sendJson({
      'type': 'get-undelivered-messages',
    });
  }

  void _checkOnlineUsers() {
    AppUtility.log('Check Online Users');
    var userIds = [];

    if (_lastMessageList.isNotEmpty) {
      userIds = _lastMessageList
          .map((e) => e.senderId == profile.profileDetails!.user!.id
              ? e.receiverId
              : e.senderId)
          .toList();
    }

    socketApiProvider.sendJson({
      'type': 'check-online-users',
      'payload': {
        'userIds': userIds,
      },
    });
  }

  void _addSocketEventListener(dynamic event) {
    var decodedData = jsonDecode(event);

    var type = decodedData['type'];
    AppUtility.log("Socket Event Type: $type");

    switch (type) {
      case 'connection':
        AppUtility.log("Socket Connected");
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
        AppUtility.log("Error: ${decodedData['message']}");
        //AppUtility.showSnackBar(decodedData['message'], StringValues.error);
        break;

      default:
        AppUtility.log("Invalid event type: $type");
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
        AppUtility.log("Invalid status: $status");
        break;
    }

    AppUtility.log('Online Users: ${_onlineUsers.length}');
  }

  void _addMessageListener(ChatMessage encryptedMessage) async {
    await saveLastMessageToLocalDB(encryptedMessage);
    await saveChatDataToLocalDB(encryptedMessage);
    await addMessageToLastMessagesList(encryptedMessage);
  }

  void _deleteMessageListener(String messageId) async {
    AppUtility.log("Chat Message Deleted $messageId");
  }

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

  bool checkIfYourMessage(ChatMessage message) {
    var yourId = profile.profileDetails!.user!.id;

    if (message.senderId == yourId) {
      return true;
    }

    return false;
  }

  /// Get message index by id from the last message list
  int _getMessageIndexByIdFromLastMessageList(ChatMessage message) {
    var index = _lastMessageList.indexWhere(
      (element) =>
          (element.senderId == message.senderId &&
              element.receiverId == message.receiverId) ||
          (element.senderId == message.receiverId &&
              element.receiverId == message.senderId),
    );

    return index;
  }

  /// Check if the message is already presentfor the same user in
  /// the last message list
  Future<bool> _checkIfSameMessageExistsForSameUserInLastMessageList(
      ChatMessage message) async {
    var currentUserId = profile.profileDetails!.user!.id;

    var key = message.senderId! + message.receiverId!;

    if (message.senderId == currentUserId) {
      key = message.receiverId! + message.senderId!;
    }

    var index = _lastMessageList.indexWhere(
      (element) =>
          (element.senderId == message.senderId &&
              element.receiverId == message.receiverId) ||
          (element.senderId == message.receiverId &&
              element.receiverId == message.senderId),
    );

    if (index < 0) return false;

    var oldMessage = _lastMessageList[index];

    var oldKey = oldMessage.senderId! + oldMessage.receiverId!;

    if (oldMessage.senderId == currentUserId) {
      oldKey = oldMessage.receiverId! + oldMessage.senderId!;
    }

    if (key == oldKey) {
      return true;
    }

    return false;
  }

  /// Check if the message is already present in the local DB
  Future<bool> _checkIfMessageExistsInLocalChatDB(
      String boxName, String key) async {
    var item = await HiveService.find<ChatMessage>(boxName, key);

    if (item != null) {
      return true;
    }

    return false;
  }

  /// Check if the message is already present in the last messages list
  /// of local DB
  Future<bool> _checkIfSameMessageExistsInLastMessagesLocalDB(
      ChatMessage message) async {
    var currentUserId = profile.profileDetails!.user!.id;

    var key = message.senderId! + message.receiverId!;

    if (message.senderId == currentUserId) {
      key = message.receiverId! + message.senderId!;
    }

    var item = await HiveService.find<ChatMessage>(_kLastMessagesKey, key);

    if (item != null) {
      if (item.id == message.id || item.tempId == message.tempId) return true;
    }

    return false;
  }

  /// Check if the last exists for the specific user
  Future<bool> _checkIfMessageExistsForUserInLastMessagesLocalDB(
      ChatMessage message) async {
    var currentUserId = profile.profileDetails!.user!.id;

    var key = message.senderId! + message.receiverId!;

    if (message.senderId == currentUserId) {
      key = message.receiverId! + message.senderId!;
    }

    var item = await HiveService.find<ChatMessage>(_kLastMessagesKey, key);

    if (item != null) {
      return true;
    }

    return false;
  }

  /// Save the message to the last messages list of local DB
  Future<void> saveLastMessageToLocalDB(ChatMessage message) async {
    var currentUserId = profile.profileDetails!.user!.id;

    var key = message.senderId! + message.receiverId!;

    if (message.senderId == currentUserId) {
      key = message.receiverId! + message.senderId!;
    }

    var messageExists =
        await _checkIfMessageExistsForUserInLastMessagesLocalDB(message);

    var isSameMessage =
        await _checkIfSameMessageExistsInLastMessagesLocalDB(message);

    if (messageExists || isSameMessage) {
      await HiveService.delete<ChatMessage>(_kLastMessagesKey, key);
      await HiveService.put<ChatMessage>(_kLastMessagesKey, key, message);

      AppUtility.log('Last message updated in local DB');

      return;
    }

    await HiveService.put<ChatMessage>(_kLastMessagesKey, key, message);
    AppUtility.log('Last message added to local DB');
  }

  /// Save the chats to the user's messages list of local DB
  Future<void> saveChatDataToLocalDB(ChatMessage message) async {
    var currentUserId = profile.profileDetails!.user!.id;

    var boxName = _kChatDataKey + message.senderId! + message.receiverId!;

    if (message.senderId == currentUserId) {
      boxName = _kChatDataKey + message.receiverId! + message.senderId!;
    }

    var key = message.id ?? message.tempId;

    if (key == null) {
      AppUtility.log('Key is null', tag: 'error');
      return;
    }

    var isSameMessage = await _checkIfMessageExistsInLocalChatDB(boxName, key);

    if (isSameMessage) {
      await HiveService.delete<ChatMessage>(boxName, key);
      await HiveService.put<ChatMessage>(boxName, key, message);

      AppUtility.log('Message updated in local DB');

      return;
    }

    await HiveService.put<ChatMessage>(boxName, key, message);
    AppUtility.log('Message added to local DB');
  }

  /// Add message to last messages list
  Future<void> addMessageToLastMessagesList(ChatMessage message) async {
    var isExists =
        await _checkIfSameMessageExistsForSameUserInLastMessageList(message);

    if (isExists) {
      AppUtility.log('Message already exists in last messages list');
      var index = _getMessageIndexByIdFromLastMessageList(message);
      _lastMessageList.removeAt(index);
      _lastMessageList.add(message);
      _lastMessageList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      update();

      AppUtility.log('Last message updated in list');

      return;
    }

    _lastMessageList.add(message);
    _lastMessageList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    update();

    AppUtility.log('Last message added to list');
  }

  Future<void> _fetchLastMessages() async {
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getAllLastMessages(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setLastMessageData = ChatMessageListResponse.fromJson(decodedData);

        for (var item in _lastMessageData.value.results!) {
          await saveLastMessageToLocalDB(item);
          await addMessageToLastMessagesList(item);
        }

        _isLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar(
        StringValues.somethingWentWrong,
        StringValues.error,
      );
    }
  }

  Future<void> _loadMore() async {
    _isMoreLoading.value = true;
    update();

    var kPage = _lastMessageData.value.currentPage! + 1;

    try {
      final response =
          await _apiProvider.getAllLastMessages(_auth.token, page: kPage);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setLastMessageData = ChatMessageListResponse.fromJson(decodedData);

        for (var item in _lastMessageData.value.results!) {
          await saveLastMessageToLocalDB(item);
          await addMessageToLastMessagesList(item);
        }

        _isMoreLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isMoreLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar(
        StringValues.somethingWentWrong,
        StringValues.error,
      );
    }
  }

  Future<void> loadLocalMessages() async => await _loadLocalMessages();

  Future<void> fetchLastMessages() async => await _fetchLastMessages();

  Future<void> loadMore() async => await _loadMore();
}

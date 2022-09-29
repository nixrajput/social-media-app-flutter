import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/responses/chat_message_list_response.dart';
import 'package:social_media_app/apis/models/responses/chat_message_response.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/e2ee/signal_protocol_manager.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends GetxController {
  static ChatController get find => Get.find();

  final _auth = AuthService.find;
  final _hiveService = HiveService();
  final profile = ProfileController.find;

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _chatListData = const ChatMessageListResponse().obs;
  final List<ChatMessage> _chats = [];
  late final WebSocketChannel channel;
  late SignalProtocolManager signalProtocolManager;
  final List<ChatMessage> _conversations = [];

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  ChatMessageListResponse? get chatListData => _chatListData.value;

  List<ChatMessage> get chats => _chats;
  List<ChatMessage> get conversations => _conversations;

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }

  void initialize() {
    _initChannel().then((_) {
      _getAllLastConversation();
    });
  }

  void addToChatList(ChatMessage message) async {
    _chats.add(message);
    update();
    await _hiveService.addBox('chats', jsonEncode(_chats));
  }

  Future<void> _initChannel() async {
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
    // signalProtocolManager = SignalProtocolManager(protocolStore);

    var isChatDataExists = await _hiveService.isExists(boxName: 'chats');

    // if (isChatDataExists) {
    //   var data = await _hiveService.getBox('chats');
    //   var decodedData = jsonDecode(data) as Iterable<ChatMessage>;
    //   _chats.addAll(decodedData);
    //   update();
    // }

    channel = WebSocketChannel.connect(
        Uri.parse('${AppSecrets.awsWebSocketUrl}?token=${_auth.token}'));

    channel.stream.listen(
      (value) async {
        var decodedData = jsonDecode(value);
        //AppUtility.printLog(decodedData['data']);

        if (decodedData['results'] != null) {
          _chatListData.value = ChatMessageListResponse.fromJson(decodedData);
          for (var element in _chatListData.value.results!) {
            var isSame = _checkIfSameMessage(element);
            if (!isSame) {
              _chats.add(element);
            }
            var index = _checkIfAlreadyPresent(element);
            if (index < 0) {
              _conversations.add(element);
            } else {
              var oldMessage = _conversations.elementAt(index);
              var isAfter = _checkIfLatestChat(oldMessage, element);
              if (isAfter) {
                _conversations.remove(oldMessage);
                _conversations.add(element);
              }
            }
          }
          update();
          AppUtility.printLog("Chat List Added");
        }
        if (decodedData['data'] != null) {
          var chatResponse = ChatMessageResponse.fromJson(decodedData);
          var encryptedMessage = chatResponse.data!.message!;
          var decryptedMessage = await _decryptMessage(encryptedMessage);
          var decrypted =
              chatResponse.data!.copyWith(message: decryptedMessage);
          _chats.add(decrypted);
          update();
          await _hiveService.addBox('chats', jsonEncode(_chats));
          AppUtility.printLog("Chat Added");
        }
      },
      onError: (err) {
        AppUtility.printLog(err);
      },
    );
  }

  Future<String> _decryptMessage(String encryptedMessage) async {
    var decryptedMessage = String.fromCharCodes(base64Decode(encryptedMessage));
    AppUtility.printLog("decryptedMessage: $decryptedMessage");
    return decryptedMessage;
  }

  bool _checkIfSameMessage(ChatMessage message) {
    var item = _conversations.any((element) => element.id == message.id);

    if (item) return true;

    return false;
  }

  int _checkIfAlreadyPresent(ChatMessage message) {
    var item = _conversations.any((element) =>
        (element.sender!.id == message.sender!.id &&
            element.receiver!.id == message.receiver!.id) ||
        (element.sender!.id == message.receiver!.id &&
            element.receiver!.id == message.sender!.id));

    if (item) {
      var index = _conversations.indexWhere((element) =>
          (element.sender!.id == message.sender!.id &&
              element.receiver!.id == message.receiver!.id) ||
          (element.sender!.id == message.receiver!.id &&
              element.receiver!.id == message.sender!.id));
      return index;
    }
    return -1;
  }

  bool _checkIfLatestChat(ChatMessage oldMessage, ChatMessage newMessage) {
    var isAfter = newMessage.createdAt!.isAfter(oldMessage.createdAt!);
    if (isAfter) return true;
    return false;
  }

  //get-all-conversations
  //get-undelivered-messages
  //get-message-by-id

  _getAllLastConversation({int? page}) {
    channel.sink.add(
      jsonEncode(
        {
          'type': 'get-all-conversations',
          'payload': {
            'limit': 5,
            'page': page,
          }
        },
      ),
    );
  }
}

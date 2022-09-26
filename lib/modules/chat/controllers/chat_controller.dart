import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/responses/chat_message_list_response.dart';
import 'package:social_media_app/apis/models/responses/chat_message_response.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/e2ee/signal_protocol_manager.dart';
import 'package:social_media_app/e2ee/signal_protocol_store.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/services/e2ee_service.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends GetxController {
  static ChatController get find => Get.find();

  final _auth = AuthService.find;
  final _e2eeService = E2EEService();
  final _hiveService = HiveService();
  final profile = ProfileController.find;

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _chatListData = const ChatMessageListResponse().obs;
  final List<ChatMessage> _chats = [];
  late final WebSocketChannel channel;
  late SignalProtocolManager signalProtocolManager;

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  ChatMessageListResponse? get chatListData => _chatListData.value;

  List<ChatMessage> get chats => _chats;

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }

  void initialize() {
    _initChannel().then((_) {
      _savePublicKey();
    });
  }

  Future<void> _initChannel() async {
    var secretKeys = await _e2eeService.getSecretKeys();
    var regId = int.parse(
      String.fromCharCodes(base64Decode(secretKeys.registrationId)),
    );
    var identityKeyPairString = secretKeys.identityKeyPair;
    var decodedIdentityKeyPair = base64Decode(identityKeyPairString);
    var identityKeyPair =
        IdentityKeyPair.fromSerialized(decodedIdentityKeyPair);
    var protocolStore = NxSignalProtocolStore(identityKeyPair, regId);
    signalProtocolManager = SignalProtocolManager(protocolStore);

    var isChatDataExists = await _hiveService.isExists(boxName: 'chats');

    if (isChatDataExists) {
      var data = await _hiveService.getBox('chats');
      var decodedData = jsonDecode(data);
      _chats.addAll(decodedData);
    }

    channel = WebSocketChannel.connect(
        Uri.parse('${AppSecrets.awsWebSocketUrl}?token=${_auth.token}'));
    channel.stream.listen((value) async {
      var decodedData = jsonDecode(value);

      if (decodedData['results'] != null) {
        _chatListData.value = ChatMessageListResponse.fromJson(decodedData);
        _chats.addAll(_chatListData.value.results!);
        update();
        AppUtility.printLog("Chat List Added");
      }
      if (decodedData['data'] != null) {
        var chatResponse = ChatMessageResponse.fromJson(decodedData);
        if (chatResponse.data!.sender!.id != profile.profileDetails!.user!.id) {
          var decryptedMessage = await signalProtocolManager.decrypt(
            chatResponse.data!.message!,
            chatResponse.data!.sender!.id,
            102,
          );
          var chatMessage = ChatMessage(
            id: chatResponse.data!.id,
            message: decryptedMessage,
            type: chatResponse.data!.type,
            sender: chatResponse.data!.sender,
            delivered: chatResponse.data!.delivered,
            deliveredAt: chatResponse.data!.deliveredAt,
            seen: chatResponse.data!.seen,
            seenAt: chatResponse.data!.seenAt,
            deleted: chatResponse.data!.deleted,
            deletedAt: chatResponse.data!.deletedAt,
            createdAt: chatResponse.data!.createdAt,
            updatedAt: chatResponse.data!.updatedAt,
          );
          _chats.add(chatMessage);
          update();
        }
        await _hiveService.addBox('chats', jsonEncode(chats));
        AppUtility.printLog("Chat Added");
      }
    }, onError: (err) {
      AppUtility.printLog(err);
    });
  }

  _savePublicKey() async {
    var serverKeys = await _e2eeService.getServerKeys();
    channel.sink.add(
      jsonEncode(
        {
          'type': 'save-public-key',
          'payload': {
            'publicKeys': serverKeys.toJson(),
          }
        },
      ),
    );
    AppUtility.printLog("Public key saved to server");
    channel.sink.add(
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
}

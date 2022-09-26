import 'dart:convert';

import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/server_key.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

class SingleChatController extends GetxController {
  SingleChatController({
    required this.receiverId,
    required this.receiverUname,
    required this.serverKey,
  });

  static SingleChatController get find => Get.find();

  //final _auth = AuthService.find;
  final chatController = ChatController.find;
  final profile = ProfileController.find;
  final _hiveService = HiveService();

  final String receiverId;
  final String receiverUname;
  final ServerKey? serverKey;

  final messageTextController = material.TextEditingController();

  final _isLoading = false.obs;
  final _message = ''.obs;

  bool get isLoading => _isLoading.value;

  String get message => _message.value;

  void onChangedText(value) {
    _message.value = value;
    update();
  }

  // void _initData() async {
  //   _isLoading.value = true;
  //   update();
  //   var secretKeys = await _e2eeService.getSecretKeys();
  //   logs.add(secretKeys.toString());
  //   update();
  //
  //   var regId = int.parse(
  //     String.fromCharCodes(base64Decode(secretKeys.registrationId)),
  //   );
  //
  //   var preKeys = secretKeys.preKeys;
  //   var serializedPreKeys = <Uint8List>[];
  //   for (var item in preKeys) {
  //     var decodedPreKey = base64Decode(item);
  //     var preKey = PreKeyRecord.fromBuffer(decodedPreKey);
  //     serializedPreKeys.add(preKey.serialize());
  //   }
  //
  //   var signedPreKeyString = secretKeys.signedPreKey;
  //   var decodedSignedPreKey = base64Decode(signedPreKeyString);
  //   var signedPreKey = SignedPreKeyRecord.fromSerialized(decodedSignedPreKey);
  //
  //   var identityKeyPairString = secretKeys.identityKeyPair;
  //   var decodedIdentityKeyPair = base64Decode(identityKeyPairString);
  //   var identityKeyPair =
  //       IdentityKeyPair.fromSerialized(decodedIdentityKeyPair);
  //
  //   var localUser = EncryptedLocalUser(
  //     registrationId: regId,
  //     name: profile.profileDetails!.user!.uname,
  //     //deviceId: _auth.deviceId,
  //     deviceId: 101,
  //     preKeys: serializedPreKeys,
  //     signedPreKey: signedPreKey.serialize(),
  //     identityKeyPair: identityKeyPair.serialize(),
  //   );
  //

  //
  //     var remoteUser = EncryptedRemoteUser(
  //       registrationId: remoteRegId,
  //       name: receiverUname,
  //       deviceId: 102,
  //       preKeyId: remotePreKeyId,
  //       preKeyPublicKey: remotePreKeyPublicKey,
  //       signedPreKeyId: remoteSignedPreKeyId,
  //       signedPreKeyPublicKey: remoteSignedPreKeyPublicKey,
  //       signedPreKeySignature: remotePreKeySignature,
  //       identityKeyPairPublicKey: remoteIdentityKeyPairPublicKey,
  //     );
  //     session = EncryptedSession(localUser, remoteUser);
  //   }
  //   AppUtility.printLog('session created');
  //   _isLoading.value = false;
  //   update();
  // }

  void sendMessage() async {
    material.FocusManager.instance.primaryFocus!.unfocus();
    var remoteSecretKeys = serverKey;
    var remoteDeviceId = 102;

    if (remoteSecretKeys == null) {
      AppUtility.printLog('remote user keys not found');
      return;
    }
    var remoteRegId = int.parse(
      String.fromCharCodes(base64Decode(remoteSecretKeys.registrationId)),
    );

    var remotePreKeyId = int.parse(
      String.fromCharCodes(base64Decode(remoteSecretKeys.preKeyId)),
    );

    var remotePreKeyPublicKey = base64Decode(remoteSecretKeys.preKeyPublicKey);
    var remoteSignedPreKeyId = int.parse(
      String.fromCharCodes(base64Decode(remoteSecretKeys.signedPreKeyId)),
    );

    var remoteSignedPreKeyPublicKey =
        base64Decode(remoteSecretKeys.signedPreKeyPublicKey);
    var remotePreKeySignature =
        base64Decode(remoteSecretKeys.signedPreKeySignature);
    var remoteIdentityKeyPairPublicKey =
        base64Decode(remoteSecretKeys.identityKeyPairPublicKey);
    var preKeyBundle = PreKeyBundle(
      remoteRegId,
      remoteDeviceId,
      remotePreKeyId,
      Curve.decodePoint(remotePreKeyPublicKey, 0),
      remoteSignedPreKeyId,
      Curve.decodePoint(remoteSignedPreKeyPublicKey, 0),
      remotePreKeySignature,
      IdentityKey.fromBytes(remoteIdentityKeyPairPublicKey, 0),
    );
    try {
      var encryptedMessage = await chatController.signalProtocolManager
          .encrypt(message, receiverId, remoteDeviceId, preKeyBundle);
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
      var self = profile.profileDetails!.user!;
      chatController.chats.add(
        ChatMessage(
          message: message,
          type: 'text',
          sender: User(
            id: self.id,
            fname: self.fname,
            lname: self.lname,
            uname: self.uname,
            email: self.email,
            avatar: self.avatar,
            isPrivate: self.isPrivate,
            followingStatus: 'self',
            accountStatus: 'active',
            isVerified: self.isVerified,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
          ),
          //receiver: receiverId,
          deliveredAt: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      update();
      _message.value = '';
      messageTextController.clear();
      update();
      await _hiveService.addBox('chats', jsonEncode(chatController.chats));
    } on UntrustedIdentityException catch (err) {
      AppUtility.printLog('${err.key} ${err.name}');
      return;
    } on InvalidKeyException catch (err) {
      AppUtility.printLog(err.detailMessage);
      return;
    } on InvalidKeyIdException catch (err) {
      AppUtility.printLog(err.detailMessage);
      return;
    } on DuplicateMessageException catch (err) {
      AppUtility.printLog(err.detailMessage);
      return;
    }
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/e2ee/encrypted_local_user.dart';
import 'package:social_media_app/e2ee/encrypted_remote_user.dart';
import 'package:social_media_app/e2ee/encrypted_session.dart';
import 'package:social_media_app/utils/utility.dart';

class SingleChatController extends GetxController {
  static SingleChatController get find => Get.find();

  final auth = AuthService.find;

  final messageTextController = TextEditingController();

  final _isLoading = false.obs;
  final _message = ''.obs;

  bool get isLoading => _isLoading.value;

  String get message => _message.value;

  List<String> logs = [];

  void onChangedText(value) {
    _message.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() async {
    logs.add("Controller Initialized...");
    update();
  }

  void testEncryption() async {
    logs.add("Encryption/Decryption Started");
    update();
    final identityKeyPair = generateIdentityKeyPair();
    final registrationId = generateRegistrationId(false);
    final preKeys = generatePreKeys(0, 110);
    final signedPreKey = generateSignedPreKey(identityKeyPair, 2);

    var serializedPreKeys = <Uint8List>[];
    for (var item in preKeys) {
      serializedPreKeys.add(item.serialize());
    }

    AppUtility.printLog('Bob Secrets generated');
    logs.add("Bob secrets generated");
    update();

    var bobAsLocalUser = EncryptedLocalUser(
      registrationId: registrationId,
      name: 'bob',
      deviceId: 1,
      preKeys: serializedPreKeys,
      signedPreKey: signedPreKey.serialize(),
      identityKeyPair: identityKeyPair.serialize(),
    );

    var bobAsRemoteUser = EncryptedRemoteUser(
      registrationId: registrationId,
      name: 'bob',
      deviceId: 1,
      preKeyId: preKeys.elementAt(0).id,
      preKeyPublicKey: preKeys.elementAt(0).getKeyPair().publicKey.serialize(),
      signedPreKeyId: signedPreKey.id,
      signedPreKeyPublicKey: signedPreKey.getKeyPair().publicKey.serialize(),
      signedPreKeySignature: signedPreKey.signature,
      identityKeyPairPublicKey: identityKeyPair.getPublicKey().serialize(),
    );

    // Should get remote from the server
    final remoteRegId = generateRegistrationId(false);
    final remoteIdentityKeyPair = generateIdentityKeyPair();
    final remotePreKeys = generatePreKeys(0, 110);
    final remoteSignedPreKey = generateSignedPreKey(remoteIdentityKeyPair, 5);

    var serializedRemotePreKeys = <Uint8List>[];
    for (var item in remotePreKeys) {
      serializedRemotePreKeys.add(item.serialize());
    }

    AppUtility.printLog('Alice Secrets generated');
    logs.add("Alice secrets generated");
    update();

    var aliceAsLocalUser = EncryptedLocalUser(
      registrationId: remoteRegId,
      name: 'alice',
      deviceId: 2,
      preKeys: serializedRemotePreKeys,
      signedPreKey: remoteSignedPreKey.serialize(),
      identityKeyPair: remoteIdentityKeyPair.serialize(),
    );

    var aliceAsRemoteUser = EncryptedRemoteUser(
      registrationId: remoteRegId,
      name: 'alice',
      deviceId: 2,
      preKeyId: remotePreKeys.elementAt(0).id,
      preKeyPublicKey:
          remotePreKeys.elementAt(0).getKeyPair().publicKey.serialize(),
      signedPreKeyId: remoteSignedPreKey.id,
      signedPreKeyPublicKey:
          remoteSignedPreKey.getKeyPair().publicKey.serialize(),
      signedPreKeySignature: remoteSignedPreKey.signature,
      identityKeyPairPublicKey:
          remoteIdentityKeyPair.getPublicKey().serialize(),
    );

    var bobToAliceSession = EncryptedSession(bobAsLocalUser, aliceAsRemoteUser);
    AppUtility.printLog('Session Created: Bob To Alice');
    logs.add("Session Created: Bob To Alice");
    update();
    var aliceToBobSession = EncryptedSession(aliceAsLocalUser, bobAsRemoteUser);
    AppUtility.printLog('Session Created: Alice To Bob');
    logs.add("Session Created: Alice To Bob");
    update();

    var check = bobToAliceSession == aliceToBobSession;
    AppUtility.printLog('Same session: $check');

    try {
      var bobEncryptedMessage =
          await bobToAliceSession.encrypt('Hello from Bob');
      logs.add("Message: Hello from Bob");
      update();
      AppUtility.printLog('Encrypted message at Bob end: $bobEncryptedMessage');
      logs.add("Encrypted message at Bob end: $bobEncryptedMessage");
      update();

      var aliceDecryptedMessage =
          await aliceToBobSession.decrypt(bobEncryptedMessage);
      AppUtility.printLog(
          'Decrypted message at Alice end: $aliceDecryptedMessage');
      logs.add("Decrypted message at Alice end: $aliceDecryptedMessage");
      update();
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

    /// ------------------------------------------------------------------------

    try {
      var aliceEncryptedMessage =
          await aliceToBobSession.encrypt('Hello from Alice');
      logs.add("Message: Hello from Alice");
      update();
      AppUtility.printLog(
          'Encrypted message at Alice end: $aliceEncryptedMessage');
      logs.add("Encrypted message at Alice end: $aliceEncryptedMessage");
      update();

      var bobDecryptedMessage =
          await bobToAliceSession.decrypt(aliceEncryptedMessage);
      AppUtility.printLog('Decrypted message at Bob end: $bobDecryptedMessage');
      logs.add("Decrypted message at Bob end: $bobDecryptedMessage");
      update();
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
    logs.add("Encryption/Decryption Finished");
    update();
  }
}

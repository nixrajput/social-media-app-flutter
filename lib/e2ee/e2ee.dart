import 'dart:convert';
import 'dart:typed_data';

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/e2ee/encrypted_local_user.dart';
import 'package:social_media_app/e2ee/encrypted_remote_user.dart';
import 'package:social_media_app/e2ee/encrypted_session.dart';
import 'package:social_media_app/utils/utility.dart';

class E2EE {
  E2EE._();

  static final instance = E2EE._();

  static void generateAndSaveIdentityKeyPair() {
    final identityKeyPair = generateIdentityKeyPair();
    var encodedIdentityKeyPair = base64Encode(identityKeyPair.serialize());
    AppUtility.printLog('IdentityKeyPair generated');
    AppUtility.printLog('base64IdentityKeyPair: $encodedIdentityKeyPair');
  }

  static void generateAndSaveRegistrationId() {
    final registrationId = generateRegistrationId(false);
    var encodedRegId = base64Encode(registrationId.toString().codeUnits);
    AppUtility.printLog('RegistrationId generated');
    AppUtility.printLog('base64RegistrationId: $encodedRegId');
  }

  static void generateAndSavePreKeys() {
    final preKeys = generatePreKeys(0, 110);

    for (var keys in preKeys) {
      var encodedPreKey = base64Encode(keys.serialize());
      AppUtility.printLog('encodedPreKey: $encodedPreKey');
    }
    AppUtility.printLog('PreKeys generated');
  }

  static void generateAndSaveSignedPreKey(IdentityKeyPair identityKeyPair) {
    final signedPreKey = generateSignedPreKey(identityKeyPair, 2);
    var encodedSignedPreKey = base64Encode(signedPreKey.serialize());
    AppUtility.printLog('encodedSignedPreKey generated');
    AppUtility.printLog('encodedSignedPreKey: $encodedSignedPreKey');
  }

  Future<void> test() async {
    final identityKeyPair = generateIdentityKeyPair();
    final registrationId = generateRegistrationId(false);
    final preKeys = generatePreKeys(0, 110);
    final signedPreKey = generateSignedPreKey(identityKeyPair, 2);

    // generateAndSaveIdentityKeyPair();
    // generateAndSaveRegistrationId();
    // generateAndSavePreKeys();
    // generateAndSaveSignedPreKey(identityKeyPair);

    var serializedPreKeys = <Uint8List>[];
    for (var item in preKeys) {
      serializedPreKeys.add(item.serialize());
    }

    AppUtility.printLog('Bob Secrets generated');

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
    var aliceToBobSession = EncryptedSession(aliceAsLocalUser, bobAsRemoteUser);
    AppUtility.printLog('Session Created: Alice To Bob');

    try {
      var bobEncryptedMessage =
          await bobToAliceSession.encrypt('Hello from Bob');
      AppUtility.printLog('Encrypted message at Bob end: $bobEncryptedMessage');

      var aliceDecryptedMessage =
          await aliceToBobSession.decrypt(bobEncryptedMessage);
      AppUtility.printLog(
          'Decrypted message at Alice end: $aliceDecryptedMessage');
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
      AppUtility.printLog(
          'Encrypted message at Alice end: $aliceEncryptedMessage');

      var bobDecryptedMessage =
          await bobToAliceSession.decrypt(aliceEncryptedMessage);
      AppUtility.printLog('Decrypted message at Bob end: $bobDecryptedMessage');
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

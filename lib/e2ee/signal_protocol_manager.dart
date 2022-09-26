import 'dart:convert';
import 'dart:typed_data';

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/e2ee/signal_protocol_store.dart';

class SignalProtocolManager {
  final NxSignalProtocolStore store;

  SignalProtocolManager(this.store);

  Future<String> encrypt(
    String message,
    String remoteUserId,
    int remoteDeviceId,
    PreKeyBundle preKeyBundle,
  ) async {
    var sessionCipher = await store.loadSessionCipher(remoteUserId);

    if (sessionCipher == null) {
      var remoteAddress = SignalProtocolAddress(remoteUserId, remoteDeviceId);
      var sessionBuilder = SessionBuilder.fromSignalStore(
        store,
        remoteAddress,
      );

      // Get preKeyBundleFromServer
      //var remoteUserPreKey = getPreKeyBundleFromServer(remoteUserId);
      await sessionBuilder.processPreKeyBundle(preKeyBundle);
      var sessionCipher = SessionCipher.fromStore(store, remoteAddress);
      await store.storeSessionCipher(remoteUserId, sessionCipher);
    }

    var ciphertextMessage = await sessionCipher!.encrypt(
      Uint8List.fromList(utf8.encode(message)),
    );
    var preKeySignalMessage =
        PreKeySignalMessage(ciphertextMessage.serialize());
    return base64UrlEncode(preKeySignalMessage.serialized);
  }

  Future<String> decrypt(
    String encryptedMessage,
    String remoteUserId,
    int remoteDeviceId,
  ) async {
    var sessionCipher = await store.loadSessionCipher(remoteUserId);
    var remoteAddress = SignalProtocolAddress(remoteUserId, remoteDeviceId);
    if (sessionCipher == null) {
      var sessionCipher = SessionCipher.fromStore(store, remoteAddress);
      await store.storeSessionCipher(remoteUserId, sessionCipher);
    }

    var bytes = Uint8List.fromList(base64Decode(encryptedMessage));
    Uint8List? decryptedMessage;

    if (!await store.containsSession(remoteAddress)) {
      decryptedMessage = await sessionCipher!
          .decryptFromSignal(SignalMessage.fromSerialized(bytes));
    } else {
      decryptedMessage =
          await sessionCipher!.decrypt(PreKeySignalMessage(bytes));
    }
    return utf8.decode(decryptedMessage);
  }
}

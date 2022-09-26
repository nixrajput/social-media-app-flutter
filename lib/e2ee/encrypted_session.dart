import 'dart:convert';
import 'dart:typed_data';

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/e2ee/encrypted_local_user.dart';
import 'package:social_media_app/e2ee/encrypted_remote_user.dart';
import 'package:social_media_app/utils/utility.dart';

enum Operation { encrypt, decrypt }

class EncryptedSession {
  SessionCipher? _sessionCipher;
  Operation? _lastOp;
  SignalProtocolAddress? _protocolAddress;
  EncryptedLocalUser? _localUser;
  EncryptedRemoteUser? _remoteUser;
  InMemorySignalProtocolStore? _protocolStore;

  EncryptedSession(
      EncryptedLocalUser localUser, EncryptedRemoteUser remoteUser) {
    _protocolAddress = remoteUser.getSignalProtocolAddress!;
    _localUser = localUser;
    _remoteUser = remoteUser;
  }

  Future<void> _createSession(Operation operation) async {
    if (operation == _lastOp) {
      return;
    }

    _protocolStore = InMemorySignalProtocolStore(
      _localUser!.getIdentityKeyPair!,
      _localUser!.getRegistrationId!,
    );

    for (var item in _localUser!.getPreKeys!) {
      await _protocolStore!.storePreKey(item.id, item);
    }

    await _protocolStore!.storeSignedPreKey(
      _localUser!.getSignedPreKey!.id,
      _localUser!.getSignedPreKey!,
    );

    var preKeyBundle = PreKeyBundle(
      _remoteUser!.getRegistrationId!,
      _remoteUser!.getSignalProtocolAddress!.getDeviceId(),
      _remoteUser!.getPreKeyId!,
      _remoteUser!.getPreKeyPublicKey!,
      _remoteUser!.getSignedPreKeyId!,
      _remoteUser!.getSignedPreKeyPublicKey!,
      _remoteUser!.getSignedPreKeySignature!,
      _remoteUser!.getIdentityKeyPairPublicKey!,
    );

    /// Session
    if (!await _protocolStore!.containsSession(_protocolAddress!)) {
      await SessionBuilder.fromSignalStore(
        _protocolStore!,
        _remoteUser!.getSignalProtocolAddress!,
      ).processPreKeyBundle(preKeyBundle);
    }

    _sessionCipher =
        SessionCipher.fromStore(_protocolStore!, _protocolAddress!);
    _lastOp = operation;
  }

  Future<String> encrypt(String message) async {
    try {
      await _createSession(Operation.encrypt);
      var ciphertextMessage = await _sessionCipher!.encrypt(
        Uint8List.fromList(utf8.encode(message)),
      );
      var preKeySignalMessage =
          PreKeySignalMessage(ciphertextMessage.serialize());
      return base64UrlEncode(preKeySignalMessage.serialized);
    } on UntrustedIdentityException {
      rethrow;
    } on InvalidKeyException {
      rethrow;
    } on InvalidKeyIdException {
      rethrow;
    } on DuplicateMessageException {
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  Future<String> decrypt(String encryptedMessage) async {
    try {
      await _createSession(Operation.decrypt);
      var bytes = Uint8List.fromList(base64Decode(encryptedMessage));
      Uint8List? decryptedMessage;

      if (_sessionCipher == null) {
        AppUtility.printLog('session cipher not found');
        return 'An error occurred while decrypting message';
      }

      if (!await _protocolStore!.containsSession(_protocolAddress!)) {
        decryptedMessage = await _sessionCipher!
            .decryptFromSignal(SignalMessage.fromSerialized(bytes));
      } else {
        decryptedMessage =
            await _sessionCipher!.decrypt(PreKeySignalMessage(bytes));
      }
      return utf8.decode(decryptedMessage);
    } on UntrustedIdentityException {
      rethrow;
    } on InvalidKeyException {
      rethrow;
    } on InvalidKeyIdException {
      rethrow;
    } on DuplicateMessageException {
      rethrow;
    } catch (err) {
      rethrow;
    }
  }
}

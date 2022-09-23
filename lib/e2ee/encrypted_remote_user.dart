import 'dart:typed_data';

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/e2ee/base_encrypted_user.dart';

class EncryptedRemoteUser extends BaseEncryptedUser {
  int? _preKeyId;
  ECPublicKey? _preKeyPublicKey;
  int? _signedPreKeyId;
  ECPublicKey? _signedPreKeyPublicKey;
  Uint8List? _signedPreKeySignature;
  IdentityKey? _identityKeyPairPublicKey;

  EncryptedRemoteUser({
    required int registrationId,
    required String name,
    required int deviceId,
    required int preKeyId,
    required Uint8List preKeyPublicKey,
    required int signedPreKeyId,
    required Uint8List signedPreKeyPublicKey,
    required Uint8List signedPreKeySignature,
    required Uint8List identityKeyPairPublicKey,
  }) : super(registrationId, SignalProtocolAddress(name, deviceId)) {
    _preKeyId = preKeyId;
    _preKeyPublicKey = Curve.decodePoint(preKeyPublicKey, 0);
    _signedPreKeyId = signedPreKeyId;
    _signedPreKeyPublicKey = Curve.decodePoint(signedPreKeyPublicKey, 0);
    _signedPreKeySignature = signedPreKeySignature;
    _identityKeyPairPublicKey =
        IdentityKey.fromBytes(identityKeyPairPublicKey, 0);
  }

  int? get getPreKeyId => _preKeyId;

  ECPublicKey? get getPreKeyPublicKey => _preKeyPublicKey;

  int? get getSignedPreKeyId => _signedPreKeyId;

  ECPublicKey? get getSignedPreKeyPublicKey => _signedPreKeyPublicKey;

  Uint8List? get getSignedPreKeySignature => _signedPreKeySignature;

  IdentityKey? get getIdentityKeyPairPublicKey => _identityKeyPairPublicKey;
}

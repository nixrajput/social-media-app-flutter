import 'dart:typed_data';

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/e2ee/base_encrypted_user.dart';

class EncryptedLocalUser extends BaseEncryptedUser {
  IdentityKeyPair? _identityKeyPair;
  List<PreKeyRecord>? _preKey;
  SignedPreKeyRecord? _signedPreKey;

  EncryptedLocalUser({
    required int registrationId,
    required String name,
    required int deviceId,
    required List<Uint8List> preKeys,
    required Uint8List signedPreKey,
    required Uint8List identityKeyPair,
  }) : super(registrationId, SignalProtocolAddress(name, deviceId)) {
    _identityKeyPair = IdentityKeyPair.fromSerialized(identityKeyPair);
    _preKey = [];
    for (var item in preKeys) {
      _preKey?.add(PreKeyRecord.fromBuffer(item));
    }
    _signedPreKey = SignedPreKeyRecord.fromSerialized(signedPreKey);
  }

  static PreKeyRecord toPreKeyRecord(Uint8List record) {
    return PreKeyRecord.fromBuffer(record);
  }

  IdentityKeyPair? get getIdentityKeyPair => _identityKeyPair;

  List<PreKeyRecord>? get getPreKeys => _preKey;

  SignedPreKeyRecord? get getSignedPreKey => _signedPreKey;
}

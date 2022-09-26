import 'dart:convert';

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/apis/models/entities/secret_key.dart';
import 'package:social_media_app/apis/models/entities/server_key.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

class E2EEService {
  final _hiveService = HiveService();

  Future<ServerKey> getServerKeys() async {
    var secretKeys = await getSecretKeys();

    var regId = int.parse(
      String.fromCharCodes(base64Decode(secretKeys.registrationId)),
    );

    var preKeys = secretKeys.preKeys;
    var decodedPreKey = base64Decode(preKeys.elementAt(0));
    var preKey = PreKeyRecord.fromBuffer(decodedPreKey);

    var signedPreKeyString = secretKeys.signedPreKey;
    var decodedSignedPreKey = base64Decode(signedPreKeyString);
    var signedPreKey = SignedPreKeyRecord.fromSerialized(decodedSignedPreKey);

    var identityKeyPairString = secretKeys.identityKeyPair;
    var decodedIdentityKeyPair = base64Decode(identityKeyPairString);
    var identityKeyPair =
        IdentityKeyPair.fromSerialized(decodedIdentityKeyPair);

    var serverKeysMap = {
      'registrationId': base64Encode(regId.toString().codeUnits),
      'preKeyId': base64Encode(preKey.id.toString().codeUnits),
      'preKeyPublicKey':
          base64Encode(preKey.getKeyPair().publicKey.serialize()),
      'signedPreKeyId': base64Encode(signedPreKey.id.toString().codeUnits),
      'signedPreKeyPublicKey':
          base64Encode(signedPreKey.getKeyPair().publicKey.serialize()),
      'signedPreKeySignature': base64Encode(signedPreKey.signature),
      'identityKeyPairPublicKey':
          base64Encode(identityKeyPair.getPublicKey().serialize()),
    };

    var serverKey = ServerKey.fromJson(serverKeysMap);

    return serverKey;
  }

  Future<SecretKey> getSecretKeys() async {
    var isSecretKeysExists = await _hiveService.isExists(boxName: 'secretKeys');

    if (!isSecretKeysExists) {
      AppUtility.printLog('secret keys does not exists');
      await _generateAndSaveKeys();
    }

    AppUtility.printLog('secret keys exists');

    var data = await _hiveService.getBox('secretKeys');
    var decodedData = jsonDecode(data);

    return SecretKey.fromJson(decodedData);
  }

  Future<void> _saveSecretKeys({
    required String identityKeyPair,
    required String registrationId,
    required List<String> preKeys,
    required String signedPreKey,
  }) async {
    var secretKeys = {
      'identityKeyPair': identityKeyPair,
      'registrationId': registrationId,
      'preKeys': preKeys,
      'signedPreKey': signedPreKey,
    };

    await _hiveService.addBox('secretKeys', jsonEncode(secretKeys));
    AppUtility.printLog('secret keys saved to local');
  }

  Future<void> _generateAndSaveKeys() async {
    var identityKeyPair = await _generateIdentityKeyPair();
    var regId = await _generateRegistrationId();
    var preKeys = await _generatePreKeys();

    var decodedIdentityKeyPair = base64Decode(identityKeyPair);
    var idKeyPair = IdentityKeyPair.fromSerialized(decodedIdentityKeyPair);

    var signedPreKey = await _generateSignedPreKey(idKeyPair);

    AppUtility.printLog('secret keys generated');

    await _saveSecretKeys(
      identityKeyPair: identityKeyPair,
      registrationId: regId,
      preKeys: preKeys,
      signedPreKey: signedPreKey,
    );
  }

  Future<String> _generateIdentityKeyPair() async {
    final identityKeyPair = generateIdentityKeyPair();
    var base64IdentityKeyPair = base64Encode(identityKeyPair.serialize());
    AppUtility.printLog('IdentityKeyPair generated');
    AppUtility.printLog('base64IdentityKeyPair: $base64IdentityKeyPair');
    return base64IdentityKeyPair;
  }

  Future<String> _generateRegistrationId() async {
    final registrationId = generateRegistrationId(false);
    var base64RegId = base64Encode(registrationId.toString().codeUnits);
    AppUtility.printLog('RegistrationId generated');
    AppUtility.printLog('base64RegistrationId: $base64RegId');
    return base64RegId;
  }

  Future<List<String>> _generatePreKeys() async {
    final preKeys = generatePreKeys(0, 110);
    var base64PreKeys = <String>[];

    for (var keys in preKeys) {
      var encodedPreKey = base64Encode(keys.serialize());
      base64PreKeys.add(encodedPreKey);
    }

    AppUtility.printLog('PreKeys generated');
    AppUtility.printLog(base64PreKeys);
    return base64PreKeys;
  }

  Future<String> _generateSignedPreKey(IdentityKeyPair identityKeyPair,
      {int? signedPreKeyId}) async {
    final signedPreKey =
        generateSignedPreKey(identityKeyPair, signedPreKeyId ?? 100);
    var base64SignedPreKey = base64Encode(signedPreKey.serialize());
    AppUtility.printLog('encodedSignedPreKey generated');
    AppUtility.printLog('encodedSignedPreKey: $base64SignedPreKey');
    return base64SignedPreKey;
  }
}

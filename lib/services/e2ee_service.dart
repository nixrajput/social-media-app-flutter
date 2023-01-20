// import 'dart:convert';

// import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
// import 'package:social_media_app/apis/models/entities/secret_key.dart';
// import 'package:social_media_app/apis/models/entities/server_key.dart';
// import 'package:social_media_app/services/hive_service.dart';
// import 'package:social_media_app/utils/utility.dart';

// class E2EEService {
//   Future<ServerKey> getServerPreKeyBundle() async {
//     var secretKeys = await getSecretKeys();

//     var regId = int.parse(
//       String.fromCharCodes(base64Decode(secretKeys.registrationId)),
//     );

//     var preKeys = secretKeys.preKeys;
//     var decodedPreKey = base64Decode(preKeys.elementAt(0));
//     var preKey = PreKeyRecord.fromBuffer(decodedPreKey);

//     var signedPreKeyString = secretKeys.signedPreKey;
//     var decodedSignedPreKey = base64Decode(signedPreKeyString);
//     var signedPreKey = SignedPreKeyRecord.fromSerialized(decodedSignedPreKey);

//     var identityKeyPairString = secretKeys.identityKeyPair;
//     var decodedIdentityKeyPair = base64Decode(identityKeyPairString);
//     var identityKeyPair =
//         IdentityKeyPair.fromSerialized(decodedIdentityKeyPair);

//     var serverKey = ServerKey(
//       identityPublicKey:
//           base64Encode(identityKeyPair.getPublicKey().serialize()),
//       registrationId: base64Encode(regId.toString().codeUnits),
//       preKey: ServerPreKey(
//         keyId: base64Encode(preKey.id.toString().codeUnits),
//         publicKey: base64Encode(preKey.getKeyPair().publicKey.serialize()),
//       ),
//       signedPreKey: ServerSignedPreKey(
//         keyId: base64Encode(signedPreKey.id.toString().codeUnits),
//         publicKey:
//             base64Encode(signedPreKey.getKeyPair().publicKey.serialize()),
//         signature: base64Encode(signedPreKey.signature),
//       ),
//     );

//     return serverKey;
//   }

//   Future<PreKeyBundle> getPreKeyBundle(
//       ServerKey serverKey, int remoteDeviceId) async {
//     var registrationId = int.parse(
//       String.fromCharCodes(base64Decode(serverKey.registrationId)),
//     );
//     var preKeyId = int.parse(
//       String.fromCharCodes(base64Decode(serverKey.preKey.keyId)),
//     );
//     var preKeyPublicKey = base64Decode(serverKey.preKey.publicKey);

//     var signedPreKeyId = int.parse(
//       String.fromCharCodes(base64Decode(serverKey.signedPreKey.keyId)),
//     );
//     var signedPreKeyPublicKey = base64Decode(serverKey.signedPreKey.publicKey);
//     var signedPreKeySignature = base64Decode(serverKey.signedPreKey.signature);
//     var remoteIdentityPublicKey = base64Decode(serverKey.identityPublicKey);

//     return PreKeyBundle(
//       registrationId,
//       remoteDeviceId,
//       preKeyId,
//       Curve.decodePoint(preKeyPublicKey, 0),
//       signedPreKeyId,
//       Curve.decodePoint(signedPreKeyPublicKey, 0),
//       signedPreKeySignature,
//       IdentityKey.fromBytes(remoteIdentityPublicKey, 0),
//     );
//   }

//   Future<SecretKey> getSecretKeys() async {
//     var isSecretKeysExists = await HiveService.hasLength('secretKeys');

//     if (!isSecretKeysExists) {
//       AppUtility.log('secret keys does not exists');
//       await _generateAndSaveKeys();
//     }

//     AppUtility.log('secret keys exists');

//     var data = await HiveService.getBox<SecretKey>('secretKeys');
//     return SecretKey.fromJson();
//   }

//   Future<void> _saveSecretKeys({
//     required String identityKeyPair,
//     required String registrationId,
//     required List<String> preKeys,
//     required String signedPreKey,
//   }) async {
//     var secretKeys = {
//       'identityKeyPair': identityKeyPair,
//       'registrationId': registrationId,
//       'preKeys': preKeys,
//       'signedPreKey': signedPreKey,
//     };

//     for (var element in secretKeys.entries) {
//       await HiveService.put(
//         'secretKeys',
//         element.key,
//         element.value,
//       );
//     }
//     AppUtility.log('secret keys saved to local');
//   }

//   Future<void> _generateAndSaveKeys() async {
//     var identityKeyPair = await _generateIdentityKeyPair();
//     var regId = await _generateRegistrationId();
//     var preKeys = await _generatePreKeys();

//     var decodedIdentityKeyPair = base64Decode(identityKeyPair);
//     var idKeyPair = IdentityKeyPair.fromSerialized(decodedIdentityKeyPair);

//     var signedPreKey = await _generateSignedPreKey(idKeyPair);

//     AppUtility.printLog('secret keys generated');

//     await _saveSecretKeys(
//       identityKeyPair: identityKeyPair,
//       registrationId: regId,
//       preKeys: preKeys,
//       signedPreKey: signedPreKey,
//     );
//   }

//   Future<String> _generateIdentityKeyPair() async {
//     final identityKeyPair = generateIdentityKeyPair();
//     var base64IdentityKeyPair = base64Encode(identityKeyPair.serialize());
//     AppUtility.printLog('IdentityKeyPair generated');
//     AppUtility.printLog('base64IdentityKeyPair: $base64IdentityKeyPair');
//     return base64IdentityKeyPair;
//   }

//   Future<String> _generateRegistrationId() async {
//     final registrationId = generateRegistrationId(false);
//     var base64RegId = base64Encode(registrationId.toString().codeUnits);
//     AppUtility.printLog('RegistrationId generated');
//     AppUtility.printLog('base64RegistrationId: $base64RegId');
//     return base64RegId;
//   }

//   Future<List<String>> _generatePreKeys() async {
//     final preKeys = generatePreKeys(0, 110);
//     var base64PreKeys = <String>[];

//     for (var keys in preKeys) {
//       var encodedPreKey = base64Encode(keys.serialize());
//       base64PreKeys.add(encodedPreKey);
//     }

//     AppUtility.printLog('PreKeys generated');
//     AppUtility.printLog(base64PreKeys);
//     return base64PreKeys;
//   }

//   Future<String> _generateSignedPreKey(IdentityKeyPair identityKeyPair,
//       {int? signedPreKeyId}) async {
//     final signedPreKey =
//         generateSignedPreKey(identityKeyPair, signedPreKeyId ?? 100);
//     var base64SignedPreKey = base64Encode(signedPreKey.serialize());
//     AppUtility.printLog('encodedSignedPreKey generated');
//     AppUtility.printLog('encodedSignedPreKey: $base64SignedPreKey');
//     return base64SignedPreKey;
//   }
// }

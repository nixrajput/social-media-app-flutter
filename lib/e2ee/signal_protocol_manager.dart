import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/apis/models/entities/server_key.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/e2ee/signal_protocol_store.dart';
import 'package:social_media_app/services/e2ee_service.dart';
import 'package:social_media_app/utils/utility.dart';

class SignalProtocolManager {
  final NxSignalProtocolStore store;

  SignalProtocolManager(this.store);

  final _apiProvider = ApiProvider(http.Client());
  final _auth = AuthService.find;
  final _e2eeService = E2EEService();

  Future<String> encrypt(
    String message,
    String remoteUserId,
    int remoteDeviceId,
  ) async {
    var sessionCipher = await store.loadSessionCipher(remoteUserId);

    if (sessionCipher == null) {
      var remoteAddress = SignalProtocolAddress(remoteUserId, remoteDeviceId);
      var sessionBuilder = SessionBuilder.fromSignalStore(
        store,
        remoteAddress,
      );

      // Get preKeyBundleFromServer
      AppUtility.printLog('Get PreKeyBundle Request');
      var response =
          await _apiProvider.getPreKeyBundle(_auth.token, remoteUserId);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog('Get PreKeyBundle Success');
        AppUtility.printLog(decodedData[StringValues.message]);
        var serverKey = ServerKey.fromJson(decodedData['data']['preKeyBundle']);
        var preKeyBundle =
            await _e2eeService.getPreKeyBundle(serverKey, remoteDeviceId);
        await sessionBuilder.processPreKeyBundle(preKeyBundle);
        var sessionCipher = SessionCipher.fromStore(store, remoteAddress);
        await store.storeSessionCipher(remoteUserId, sessionCipher);
      } else {
        AppUtility.printLog('Get PreKeyBundle Error');
        AppUtility.printLog(decodedData[StringValues.message]);
        throw Exception(decodedData[StringValues.message]);
      }
    }

    sessionCipher = await store.loadSessionCipher(remoteUserId);
    var ciphertextMessage = await sessionCipher!.encrypt(
      Uint8List.fromList(utf8.encode(message)),
    );
    // var preKeySignalMessage =
    //     PreKeySignalMessage();
    return base64Encode(ciphertextMessage.serialize());
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

    sessionCipher = await store.loadSessionCipher(remoteUserId);
    var messageBytes = base64Decode(encryptedMessage);
    Uint8List? decryptedMessage;

    if (!await store.containsSession(remoteAddress)) {
      decryptedMessage = await sessionCipher!
          .decryptFromSignal(SignalMessage.fromSerialized(messageBytes));
    } else {
      decryptedMessage =
          await sessionCipher!.decrypt(PreKeySignalMessage(messageBytes));
    }
    return utf8.decode(decryptedMessage);
  }
}

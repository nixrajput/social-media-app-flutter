import 'dart:collection';

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';

class InMemorySessionCipherStore {
  InMemorySessionCipherStore();

  HashMap<String, SessionCipher> sessionCiphers =
      HashMap<String, SessionCipher>();

  Future<bool> containsSessionCipher(String remoteUserId) async =>
      sessionCiphers.containsKey(remoteUserId);

  Future<void> deleteAllSessionCiphers(String remoteUserId) async {
    for (final k in sessionCiphers.keys.toList()) {
      if (k == remoteUserId) {
        sessionCiphers.remove(k);
      }
    }
  }

  Future<void> deleteSessionCipher(String remoteUserId) async {
    sessionCiphers.remove(remoteUserId);
  }

  Future<SessionCipher?>? loadSessionCipher(String remoteUserId) async {
    try {
      if (await containsSessionCipher(remoteUserId)) {
        var cipher = sessionCiphers.entries
            .singleWhere((element) => element.key == remoteUserId);
        return cipher.value;
      } else {
        return null;
      }
    } on Exception catch (e) {
      throw AssertionError(e);
    }
  }

  Future<void> storeSessionCipher(
      String remoteUserId, SessionCipher cipher) async {
    sessionCiphers[remoteUserId] = cipher;
  }
}

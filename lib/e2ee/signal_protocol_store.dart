import 'dart:core';

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:social_media_app/e2ee/in_memory_session_cipher_store.dart';

class NxSignalProtocolStore implements SignalProtocolStore {
  NxSignalProtocolStore(IdentityKeyPair identityKeyPair, int registrationId) {
    _identityKeyStore =
        InMemoryIdentityKeyStore(identityKeyPair, registrationId);
  }

  final preKeyStore = InMemoryPreKeyStore();
  final sessionStore = InMemorySessionStore();
  final signedPreKeyStore = InMemorySignedPreKeyStore();
  final sessionCipherStore = InMemorySessionCipherStore();

  late IdentityKeyStore _identityKeyStore;

  @override
  Future<IdentityKeyPair> getIdentityKeyPair() async =>
      _identityKeyStore.getIdentityKeyPair();

  @override
  Future<int> getLocalRegistrationId() async =>
      _identityKeyStore.getLocalRegistrationId();

  @override
  Future<bool> saveIdentity(
          SignalProtocolAddress address, IdentityKey? identityKey) async =>
      _identityKeyStore.saveIdentity(address, identityKey);

  @override
  Future<bool> isTrustedIdentity(SignalProtocolAddress address,
          IdentityKey? identityKey, Direction direction) async =>
      _identityKeyStore.isTrustedIdentity(address, identityKey, direction);

  @override
  Future<IdentityKey?> getIdentity(SignalProtocolAddress address) async =>
      _identityKeyStore.getIdentity(address);

  @override
  Future<PreKeyRecord> loadPreKey(int preKeyId) async =>
      preKeyStore.loadPreKey(preKeyId);

  @override
  Future<void> storePreKey(int preKeyId, PreKeyRecord record) async {
    await preKeyStore.storePreKey(preKeyId, record);
  }

  @override
  Future<bool> containsPreKey(int preKeyId) async =>
      preKeyStore.containsPreKey(preKeyId);

  @override
  Future<void> removePreKey(int preKeyId) async {
    await preKeyStore.removePreKey(preKeyId);
  }

  @override
  Future<SessionRecord> loadSession(SignalProtocolAddress address) async =>
      sessionStore.loadSession(address);

  @override
  Future<List<int>> getSubDeviceSessions(String name) async =>
      sessionStore.getSubDeviceSessions(name);

  @override
  Future<void> storeSession(
      SignalProtocolAddress address, SessionRecord record) async {
    await sessionStore.storeSession(address, record);
  }

  @override
  Future<bool> containsSession(SignalProtocolAddress address) async =>
      sessionStore.containsSession(address);

  @override
  Future<void> deleteSession(SignalProtocolAddress address) async {
    await sessionStore.deleteSession(address);
  }

  @override
  Future<void> deleteAllSessions(String name) async {
    await sessionStore.deleteAllSessions(name);
  }

  @override
  Future<SignedPreKeyRecord> loadSignedPreKey(int signedPreKeyId) async =>
      signedPreKeyStore.loadSignedPreKey(signedPreKeyId);

  @override
  Future<List<SignedPreKeyRecord>> loadSignedPreKeys() async =>
      signedPreKeyStore.loadSignedPreKeys();

  @override
  Future<void> storeSignedPreKey(
      int signedPreKeyId, SignedPreKeyRecord record) async {
    await signedPreKeyStore.storeSignedPreKey(signedPreKeyId, record);
  }

  @override
  Future<bool> containsSignedPreKey(int signedPreKeyId) async =>
      signedPreKeyStore.containsSignedPreKey(signedPreKeyId);

  @override
  Future<void> removeSignedPreKey(int signedPreKeyId) async {
    await signedPreKeyStore.removeSignedPreKey(signedPreKeyId);
  }

  Future<void> storeSessionCipher(
      String remoteUserId, SessionCipher cipher) async {
    await sessionCipherStore.storeSessionCipher(remoteUserId, cipher);
  }

  Future<SessionCipher?>? loadSessionCipher(String remoteUserId) async =>
      await sessionCipherStore.loadSessionCipher(remoteUserId);

  Future<bool> containsSessionCipher(String remoteUserId) async =>
      await sessionCipherStore.containsSessionCipher(remoteUserId);

  Future<void> deleteAllSessionCiphers(String remoteUserId) async {
    await sessionCipherStore.deleteAllSessionCiphers(remoteUserId);
  }

  Future<void> deleteSessionCipher(String remoteUserId) async {
    await sessionCipherStore.deleteSessionCipher(remoteUserId);
  }
}

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';

abstract class BaseEncryptedUser {
  int? _registrationId;
  SignalProtocolAddress? _address;

  BaseEncryptedUser(int registrationId, SignalProtocolAddress address) {
    _registrationId = registrationId;
    _address = address;
  }

  int? get getRegistrationId => _registrationId;

  SignalProtocolAddress? get getSignalProtocolAddress => _address;
}

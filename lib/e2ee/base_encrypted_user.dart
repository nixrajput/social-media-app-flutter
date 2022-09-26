import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';

abstract class BaseEncryptedUser {
  final int _registrationId;
  final SignalProtocolAddress _address;

  BaseEncryptedUser(this._registrationId, this._address);

  int? get getRegistrationId => _registrationId;

  SignalProtocolAddress? get getSignalProtocolAddress => _address;

  @override
  String toString() => '$_registrationId:${_address.toString()}';

  @override
  bool operator ==(Object other) {
    if (other is! BaseEncryptedUser) return false;

    return _registrationId == other._registrationId &&
        _address == other._address;
  }

  @override
  int get hashCode => _address.hashCode ^ _registrationId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_key.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerKeyAdapter extends TypeAdapter<ServerKey> {
  @override
  final int typeId = 10;

  @override
  ServerKey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerKey(
      identityPublicKey: fields[0] as String,
      registrationId: fields[1] as String,
      preKey: fields[2] as ServerPreKey,
      signedPreKey: fields[3] as ServerSignedPreKey,
    );
  }

  @override
  void write(BinaryWriter writer, ServerKey obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.identityPublicKey)
      ..writeByte(1)
      ..write(obj.registrationId)
      ..writeByte(2)
      ..write(obj.preKey)
      ..writeByte(3)
      ..write(obj.signedPreKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerKeyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerKey _$ServerKeyFromJson(Map<String, dynamic> json) => ServerKey(
      identityPublicKey: json['identityPublicKey'] as String,
      registrationId: json['registrationId'] as String,
      preKey: ServerPreKey.fromJson(json['preKey'] as Map<String, dynamic>),
      signedPreKey: ServerSignedPreKey.fromJson(
          json['signedPreKey'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServerKeyToJson(ServerKey instance) => <String, dynamic>{
      'identityPublicKey': instance.identityPublicKey,
      'registrationId': instance.registrationId,
      'preKey': instance.preKey,
      'signedPreKey': instance.signedPreKey,
    };

ServerPreKey _$ServerPreKeyFromJson(Map<String, dynamic> json) => ServerPreKey(
      keyId: json['keyId'] as String,
      publicKey: json['publicKey'] as String,
    );

Map<String, dynamic> _$ServerPreKeyToJson(ServerPreKey instance) =>
    <String, dynamic>{
      'keyId': instance.keyId,
      'publicKey': instance.publicKey,
    };

ServerSignedPreKey _$ServerSignedPreKeyFromJson(Map<String, dynamic> json) =>
    ServerSignedPreKey(
      keyId: json['keyId'] as String,
      publicKey: json['publicKey'] as String,
      signature: json['signature'] as String,
    );

Map<String, dynamic> _$ServerSignedPreKeyToJson(ServerSignedPreKey instance) =>
    <String, dynamic>{
      'keyId': instance.keyId,
      'publicKey': instance.publicKey,
      'signature': instance.signature,
    };

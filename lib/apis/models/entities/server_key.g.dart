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
      registrationId: fields[0] as String,
      preKeyId: fields[1] as String,
      preKeyPublicKey: fields[2] as String,
      signedPreKeyId: fields[3] as String,
      signedPreKeyPublicKey: fields[4] as String,
      signedPreKeySignature: fields[5] as String,
      identityKeyPairPublicKey: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServerKey obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.registrationId)
      ..writeByte(1)
      ..write(obj.preKeyId)
      ..writeByte(2)
      ..write(obj.preKeyPublicKey)
      ..writeByte(3)
      ..write(obj.signedPreKeyId)
      ..writeByte(4)
      ..write(obj.signedPreKeyPublicKey)
      ..writeByte(5)
      ..write(obj.signedPreKeySignature)
      ..writeByte(6)
      ..write(obj.identityKeyPairPublicKey);
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
      registrationId: json['registrationId'] as String,
      preKeyId: json['preKeyId'] as String,
      preKeyPublicKey: json['preKeyPublicKey'] as String,
      signedPreKeyId: json['signedPreKeyId'] as String,
      signedPreKeyPublicKey: json['signedPreKeyPublicKey'] as String,
      signedPreKeySignature: json['signedPreKeySignature'] as String,
      identityKeyPairPublicKey: json['identityKeyPairPublicKey'] as String,
    );

Map<String, dynamic> _$ServerKeyToJson(ServerKey instance) => <String, dynamic>{
      'registrationId': instance.registrationId,
      'preKeyId': instance.preKeyId,
      'preKeyPublicKey': instance.preKeyPublicKey,
      'signedPreKeyId': instance.signedPreKeyId,
      'signedPreKeyPublicKey': instance.signedPreKeyPublicKey,
      'signedPreKeySignature': instance.signedPreKeySignature,
      'identityKeyPairPublicKey': instance.identityKeyPairPublicKey,
    };

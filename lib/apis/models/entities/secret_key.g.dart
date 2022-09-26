// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret_key.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SecretKeyAdapter extends TypeAdapter<SecretKey> {
  @override
  final int typeId = 9;

  @override
  SecretKey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecretKey(
      identityKeyPair: fields[0] as String,
      registrationId: fields[1] as String,
      preKeys: (fields[2] as List).cast<String>(),
      signedPreKey: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SecretKey obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.identityKeyPair)
      ..writeByte(1)
      ..write(obj.registrationId)
      ..writeByte(2)
      ..write(obj.preKeys)
      ..writeByte(3)
      ..write(obj.signedPreKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecretKeyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecretKey _$SecretKeyFromJson(Map<String, dynamic> json) => SecretKey(
      identityKeyPair: json['identityKeyPair'] as String,
      registrationId: json['registrationId'] as String,
      preKeys:
          (json['preKeys'] as List<dynamic>).map((e) => e as String).toList(),
      signedPreKey: json['signedPreKey'] as String,
    );

Map<String, dynamic> _$SecretKeyToJson(SecretKey instance) => <String, dynamic>{
      'identityKeyPair': instance.identityKeyPair,
      'registrationId': instance.registrationId,
      'preKeys': instance.preKeys,
      'signedPreKey': instance.signedPreKey,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaFileAdapter extends TypeAdapter<MediaFile> {
  @override
  final int typeId = 5;

  @override
  MediaFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaFile(
      publicId: fields[0] as String?,
      url: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MediaFile obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.publicId)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaFile _$MediaFileFromJson(Map<String, dynamic> json) => MediaFile(
      publicId: json['public_id'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MediaFileToJson(MediaFile instance) => <String, dynamic>{
      'public_id': instance.publicId,
      'url': instance.url,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_media_file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostMediaFileAdapter extends TypeAdapter<PostMediaFile> {
  @override
  final int typeId = 6;

  @override
  PostMediaFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostMediaFile(
      id: fields[0] as String?,
      publicId: fields[1] as String?,
      url: fields[2] as String?,
      mediaType: fields[3] as String?,
      thumbnail: fields[4] as MediaFile?,
    );
  }

  @override
  void write(BinaryWriter writer, PostMediaFile obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.publicId)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.mediaType)
      ..writeByte(4)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostMediaFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostMediaFile _$PostMediaFileFromJson(Map<String, dynamic> json) =>
    PostMediaFile(
      id: json['_id'] as String?,
      publicId: json['public_id'] as String?,
      url: json['url'] as String?,
      mediaType: json['mediaType'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : MediaFile.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostMediaFileToJson(PostMediaFile instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'public_id': instance.publicId,
      'url': instance.url,
      'mediaType': instance.mediaType,
      'thumbnail': instance.thumbnail,
    };

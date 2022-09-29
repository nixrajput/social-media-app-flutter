// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_media_file.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PostMediaFileCWProxy {
  PostMediaFile id(String? id);

  PostMediaFile mediaType(String? mediaType);

  PostMediaFile publicId(String? publicId);

  PostMediaFile thumbnail(MediaFile? thumbnail);

  PostMediaFile url(String? url);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PostMediaFile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PostMediaFile(...).copyWith(id: 12, name: "My name")
  /// ````
  PostMediaFile call({
    String? id,
    String? mediaType,
    String? publicId,
    MediaFile? thumbnail,
    String? url,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPostMediaFile.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPostMediaFile.copyWith.fieldName(...)`
class _$PostMediaFileCWProxyImpl implements _$PostMediaFileCWProxy {
  final PostMediaFile _value;

  const _$PostMediaFileCWProxyImpl(this._value);

  @override
  PostMediaFile id(String? id) => this(id: id);

  @override
  PostMediaFile mediaType(String? mediaType) => this(mediaType: mediaType);

  @override
  PostMediaFile publicId(String? publicId) => this(publicId: publicId);

  @override
  PostMediaFile thumbnail(MediaFile? thumbnail) => this(thumbnail: thumbnail);

  @override
  PostMediaFile url(String? url) => this(url: url);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PostMediaFile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PostMediaFile(...).copyWith(id: 12, name: "My name")
  /// ````
  PostMediaFile call({
    Object? id = const $CopyWithPlaceholder(),
    Object? mediaType = const $CopyWithPlaceholder(),
    Object? publicId = const $CopyWithPlaceholder(),
    Object? thumbnail = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
  }) {
    return PostMediaFile(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      mediaType: mediaType == const $CopyWithPlaceholder()
          ? _value.mediaType
          // ignore: cast_nullable_to_non_nullable
          : mediaType as String?,
      publicId: publicId == const $CopyWithPlaceholder()
          ? _value.publicId
          // ignore: cast_nullable_to_non_nullable
          : publicId as String?,
      thumbnail: thumbnail == const $CopyWithPlaceholder()
          ? _value.thumbnail
          // ignore: cast_nullable_to_non_nullable
          : thumbnail as MediaFile?,
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String?,
    );
  }
}

extension $PostMediaFileCopyWith on PostMediaFile {
  /// Returns a callable class that can be used as follows: `instanceOfPostMediaFile.copyWith(...)` or like so:`instanceOfPostMediaFile.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PostMediaFileCWProxy get copyWith => _$PostMediaFileCWProxyImpl(this);
}

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

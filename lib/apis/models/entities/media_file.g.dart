// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_file.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MediaFileCWProxy {
  MediaFile publicId(String? publicId);

  MediaFile url(String? url);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaFile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaFile(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaFile call({
    String? publicId,
    String? url,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMediaFile.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMediaFile.copyWith.fieldName(...)`
class _$MediaFileCWProxyImpl implements _$MediaFileCWProxy {
  const _$MediaFileCWProxyImpl(this._value);

  final MediaFile _value;

  @override
  MediaFile publicId(String? publicId) => this(publicId: publicId);

  @override
  MediaFile url(String? url) => this(url: url);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaFile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaFile(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaFile call({
    Object? publicId = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
  }) {
    return MediaFile(
      publicId: publicId == const $CopyWithPlaceholder()
          ? _value.publicId
          // ignore: cast_nullable_to_non_nullable
          : publicId as String?,
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String?,
    );
  }
}

extension $MediaFileCopyWith on MediaFile {
  /// Returns a callable class that can be used as follows: `instanceOfMediaFile.copyWith(...)` or like so:`instanceOfMediaFile.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MediaFileCWProxy get copyWith => _$MediaFileCWProxyImpl(this);
}

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

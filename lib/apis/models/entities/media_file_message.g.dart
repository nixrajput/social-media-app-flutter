// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_file_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MediaFileMessageCWProxy {
  MediaFileMessage file(File file);

  MediaFileMessage message(String? message);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaFileMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaFileMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaFileMessage call({
    File? file,
    String? message,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMediaFileMessage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMediaFileMessage.copyWith.fieldName(...)`
class _$MediaFileMessageCWProxyImpl implements _$MediaFileMessageCWProxy {
  final MediaFileMessage _value;

  const _$MediaFileMessageCWProxyImpl(this._value);

  @override
  MediaFileMessage file(File file) => this(file: file);

  @override
  MediaFileMessage message(String? message) => this(message: message);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MediaFileMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MediaFileMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  MediaFileMessage call({
    Object? file = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return MediaFileMessage(
      file: file == const $CopyWithPlaceholder() || file == null
          ? _value.file
          // ignore: cast_nullable_to_non_nullable
          : file as File,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
    );
  }
}

extension $MediaFileMessageCopyWith on MediaFileMessage {
  /// Returns a callable class that can be used as follows: `instanceOfMediaFileMessage.copyWith(...)` or like so:`instanceOfMediaFileMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MediaFileMessageCWProxy get copyWith => _$MediaFileMessageCWProxyImpl(this);
}

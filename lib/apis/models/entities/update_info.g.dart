// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateInfoCWProxy {
  UpdateInfo currentVersion(String? currentVersion);

  UpdateInfo latestVersion(String? latestVersion);

  UpdateInfo changelog(String? changelog);

  UpdateInfo fileName(String? fileName);

  UpdateInfo downloadUrl(String? downloadUrl);

  UpdateInfo publishedAt(DateTime? publishedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateInfo call({
    String? currentVersion,
    String? latestVersion,
    String? changelog,
    String? fileName,
    String? downloadUrl,
    DateTime? publishedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateInfo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateInfo.copyWith.fieldName(...)`
class _$UpdateInfoCWProxyImpl implements _$UpdateInfoCWProxy {
  const _$UpdateInfoCWProxyImpl(this._value);

  final UpdateInfo _value;

  @override
  UpdateInfo currentVersion(String? currentVersion) =>
      this(currentVersion: currentVersion);

  @override
  UpdateInfo latestVersion(String? latestVersion) =>
      this(latestVersion: latestVersion);

  @override
  UpdateInfo changelog(String? changelog) => this(changelog: changelog);

  @override
  UpdateInfo fileName(String? fileName) => this(fileName: fileName);

  @override
  UpdateInfo downloadUrl(String? downloadUrl) => this(downloadUrl: downloadUrl);

  @override
  UpdateInfo publishedAt(DateTime? publishedAt) =>
      this(publishedAt: publishedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateInfo call({
    Object? currentVersion = const $CopyWithPlaceholder(),
    Object? latestVersion = const $CopyWithPlaceholder(),
    Object? changelog = const $CopyWithPlaceholder(),
    Object? fileName = const $CopyWithPlaceholder(),
    Object? downloadUrl = const $CopyWithPlaceholder(),
    Object? publishedAt = const $CopyWithPlaceholder(),
  }) {
    return UpdateInfo(
      currentVersion: currentVersion == const $CopyWithPlaceholder()
          ? _value.currentVersion
          // ignore: cast_nullable_to_non_nullable
          : currentVersion as String?,
      latestVersion: latestVersion == const $CopyWithPlaceholder()
          ? _value.latestVersion
          // ignore: cast_nullable_to_non_nullable
          : latestVersion as String?,
      changelog: changelog == const $CopyWithPlaceholder()
          ? _value.changelog
          // ignore: cast_nullable_to_non_nullable
          : changelog as String?,
      fileName: fileName == const $CopyWithPlaceholder()
          ? _value.fileName
          // ignore: cast_nullable_to_non_nullable
          : fileName as String?,
      downloadUrl: downloadUrl == const $CopyWithPlaceholder()
          ? _value.downloadUrl
          // ignore: cast_nullable_to_non_nullable
          : downloadUrl as String?,
      publishedAt: publishedAt == const $CopyWithPlaceholder()
          ? _value.publishedAt
          // ignore: cast_nullable_to_non_nullable
          : publishedAt as DateTime?,
    );
  }
}

extension $UpdateInfoCopyWith on UpdateInfo {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateInfo.copyWith(...)` or like so:`instanceOfUpdateInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateInfoCWProxy get copyWith => _$UpdateInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInfo _$UpdateInfoFromJson(Map<String, dynamic> json) => UpdateInfo(
      currentVersion: json['currentVersion'] as String?,
      latestVersion: json['latestVersion'] as String?,
      changelog: json['changelog'] as String?,
      fileName: json['fileName'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$UpdateInfoToJson(UpdateInfo instance) =>
    <String, dynamic>{
      'currentVersion': instance.currentVersion,
      'latestVersion': instance.latestVersion,
      'changelog': instance.changelog,
      'fileName': instance.fileName,
      'downloadUrl': instance.downloadUrl,
      'publishedAt': instance.publishedAt?.toIso8601String(),
    };

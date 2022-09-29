// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_device_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginDeviceInfoCWProxy {
  LoginDeviceInfo createdAt(DateTime? createdAt);

  LoginDeviceInfo deviceId(String? deviceId);

  LoginDeviceInfo deviceInfo(Map<String, dynamic>? deviceInfo);

  LoginDeviceInfo id(String? id);

  LoginDeviceInfo isActive(bool? isActive);

  LoginDeviceInfo lastActive(String? lastActive);

  LoginDeviceInfo locationInfo(LocationInfo? locationInfo);

  LoginDeviceInfo user(String? user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginDeviceInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginDeviceInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginDeviceInfo call({
    DateTime? createdAt,
    String? deviceId,
    Map<String, dynamic>? deviceInfo,
    String? id,
    bool? isActive,
    String? lastActive,
    LocationInfo? locationInfo,
    String? user,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginDeviceInfo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLoginDeviceInfo.copyWith.fieldName(...)`
class _$LoginDeviceInfoCWProxyImpl implements _$LoginDeviceInfoCWProxy {
  final LoginDeviceInfo _value;

  const _$LoginDeviceInfoCWProxyImpl(this._value);

  @override
  LoginDeviceInfo createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  LoginDeviceInfo deviceId(String? deviceId) => this(deviceId: deviceId);

  @override
  LoginDeviceInfo deviceInfo(Map<String, dynamic>? deviceInfo) =>
      this(deviceInfo: deviceInfo);

  @override
  LoginDeviceInfo id(String? id) => this(id: id);

  @override
  LoginDeviceInfo isActive(bool? isActive) => this(isActive: isActive);

  @override
  LoginDeviceInfo lastActive(String? lastActive) =>
      this(lastActive: lastActive);

  @override
  LoginDeviceInfo locationInfo(LocationInfo? locationInfo) =>
      this(locationInfo: locationInfo);

  @override
  LoginDeviceInfo user(String? user) => this(user: user);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginDeviceInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginDeviceInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginDeviceInfo call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? deviceId = const $CopyWithPlaceholder(),
    Object? deviceInfo = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? lastActive = const $CopyWithPlaceholder(),
    Object? locationInfo = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return LoginDeviceInfo(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      deviceId: deviceId == const $CopyWithPlaceholder()
          ? _value.deviceId
          // ignore: cast_nullable_to_non_nullable
          : deviceId as String?,
      deviceInfo: deviceInfo == const $CopyWithPlaceholder()
          ? _value.deviceInfo
          // ignore: cast_nullable_to_non_nullable
          : deviceInfo as Map<String, dynamic>?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      lastActive: lastActive == const $CopyWithPlaceholder()
          ? _value.lastActive
          // ignore: cast_nullable_to_non_nullable
          : lastActive as String?,
      locationInfo: locationInfo == const $CopyWithPlaceholder()
          ? _value.locationInfo
          // ignore: cast_nullable_to_non_nullable
          : locationInfo as LocationInfo?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as String?,
    );
  }
}

extension $LoginDeviceInfoCopyWith on LoginDeviceInfo {
  /// Returns a callable class that can be used as follows: `instanceOfLoginDeviceInfo.copyWith(...)` or like so:`instanceOfLoginDeviceInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginDeviceInfoCWProxy get copyWith => _$LoginDeviceInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDeviceInfo _$LoginDeviceInfoFromJson(Map<String, dynamic> json) =>
    LoginDeviceInfo(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      deviceId: json['deviceId'] as String?,
      deviceInfo: json['deviceInfo'] as Map<String, dynamic>?,
      locationInfo: json['locationInfo'] == null
          ? null
          : LocationInfo.fromJson(json['locationInfo'] as Map<String, dynamic>),
      isActive: json['isActive'] as bool?,
      lastActive: json['lastActive'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$LoginDeviceInfoToJson(LoginDeviceInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'deviceId': instance.deviceId,
      'deviceInfo': instance.deviceInfo,
      'locationInfo': instance.locationInfo,
      'isActive': instance.isActive,
      'lastActive': instance.lastActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

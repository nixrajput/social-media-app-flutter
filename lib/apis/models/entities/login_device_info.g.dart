// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_device_info.dart';

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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      id: json['_id'] as String,
      user: json['user'] as String?,
      devices: (json['devices'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'devices': instance.devices,
      'createdAt': instance.createdAt.toIso8601String(),
    };

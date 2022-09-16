// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiNotification _$ApiNotificationFromJson(Map<String, dynamic> json) =>
    ApiNotification(
      id: json['_id'] as String,
      to: User.fromJson(json['to'] as Map<String, dynamic>),
      from: User.fromJson(json['from'] as Map<String, dynamic>),
      body: json['body'] as String,
      refId: json['refId'] as String?,
      type: json['type'] as String,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ApiNotificationToJson(ApiNotification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'to': instance.to,
      'from': instance.from,
      'body': instance.body,
      'refId': instance.refId,
      'type': instance.type,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiNotification _$NotificationFromJson(Map<String, dynamic> json) =>
    ApiNotification(
      id: json['_id'] as String,
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      body: json['body'] as String,
      refId: json['refId'] as String?,
      type: json['type'] as String,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$NotificationToJson(ApiNotification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'owner': instance.owner,
      'user': instance.user,
      'body': instance.body,
      'refId': instance.refId,
      'type': instance.type,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
    };

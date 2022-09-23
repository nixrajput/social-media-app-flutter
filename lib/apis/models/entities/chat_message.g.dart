// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['_id'] as String?,
      message: json['message'] as String?,
      type: json['type '] as String?,
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      delivered: json['delivered'] as bool?,
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      seen: json['seen'] as bool?,
      seenAt: json['seenAt'] == null
          ? null
          : DateTime.parse(json['seenAt'] as String),
      deleted: json['deleted'] as bool?,
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'type ': instance.type,
      'sender': instance.sender,
      'delivered': instance.delivered,
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'seen': instance.seen,
      'seenAt': instance.seenAt?.toIso8601String(),
      'deleted': instance.deleted,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

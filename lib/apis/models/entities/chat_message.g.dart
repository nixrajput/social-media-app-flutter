// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatMessageCWProxy {
  ChatMessage createdAt(DateTime? createdAt);

  ChatMessage deleted(bool? deleted);

  ChatMessage deletedAt(DateTime? deletedAt);

  ChatMessage delivered(bool? delivered);

  ChatMessage deliveredAt(DateTime? deliveredAt);

  ChatMessage id(String? id);

  ChatMessage message(String? message);

  ChatMessage receiver(User? receiver);

  ChatMessage seen(bool? seen);

  ChatMessage seenAt(DateTime? seenAt);

  ChatMessage sender(User? sender);

  ChatMessage type(String? type);

  ChatMessage updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChatMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChatMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  ChatMessage call({
    DateTime? createdAt,
    bool? deleted,
    DateTime? deletedAt,
    bool? delivered,
    DateTime? deliveredAt,
    String? id,
    String? message,
    User? receiver,
    bool? seen,
    DateTime? seenAt,
    User? sender,
    String? type,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChatMessage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChatMessage.copyWith.fieldName(...)`
class _$ChatMessageCWProxyImpl implements _$ChatMessageCWProxy {
  final ChatMessage _value;

  const _$ChatMessageCWProxyImpl(this._value);

  @override
  ChatMessage createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  ChatMessage deleted(bool? deleted) => this(deleted: deleted);

  @override
  ChatMessage deletedAt(DateTime? deletedAt) => this(deletedAt: deletedAt);

  @override
  ChatMessage delivered(bool? delivered) => this(delivered: delivered);

  @override
  ChatMessage deliveredAt(DateTime? deliveredAt) =>
      this(deliveredAt: deliveredAt);

  @override
  ChatMessage id(String? id) => this(id: id);

  @override
  ChatMessage message(String? message) => this(message: message);

  @override
  ChatMessage receiver(User? receiver) => this(receiver: receiver);

  @override
  ChatMessage seen(bool? seen) => this(seen: seen);

  @override
  ChatMessage seenAt(DateTime? seenAt) => this(seenAt: seenAt);

  @override
  ChatMessage sender(User? sender) => this(sender: sender);

  @override
  ChatMessage type(String? type) => this(type: type);

  @override
  ChatMessage updatedAt(DateTime? updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChatMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChatMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  ChatMessage call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? deleted = const $CopyWithPlaceholder(),
    Object? deletedAt = const $CopyWithPlaceholder(),
    Object? delivered = const $CopyWithPlaceholder(),
    Object? deliveredAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? receiver = const $CopyWithPlaceholder(),
    Object? seen = const $CopyWithPlaceholder(),
    Object? seenAt = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return ChatMessage(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      deleted: deleted == const $CopyWithPlaceholder()
          ? _value.deleted
          // ignore: cast_nullable_to_non_nullable
          : deleted as bool?,
      deletedAt: deletedAt == const $CopyWithPlaceholder()
          ? _value.deletedAt
          // ignore: cast_nullable_to_non_nullable
          : deletedAt as DateTime?,
      delivered: delivered == const $CopyWithPlaceholder()
          ? _value.delivered
          // ignore: cast_nullable_to_non_nullable
          : delivered as bool?,
      deliveredAt: deliveredAt == const $CopyWithPlaceholder()
          ? _value.deliveredAt
          // ignore: cast_nullable_to_non_nullable
          : deliveredAt as DateTime?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      receiver: receiver == const $CopyWithPlaceholder()
          ? _value.receiver
          // ignore: cast_nullable_to_non_nullable
          : receiver as User?,
      seen: seen == const $CopyWithPlaceholder()
          ? _value.seen
          // ignore: cast_nullable_to_non_nullable
          : seen as bool?,
      seenAt: seenAt == const $CopyWithPlaceholder()
          ? _value.seenAt
          // ignore: cast_nullable_to_non_nullable
          : seenAt as DateTime?,
      sender: sender == const $CopyWithPlaceholder()
          ? _value.sender
          // ignore: cast_nullable_to_non_nullable
          : sender as User?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $ChatMessageCopyWith on ChatMessage {
  /// Returns a callable class that can be used as follows: `instanceOfChatMessage.copyWith(...)` or like so:`instanceOfChatMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChatMessageCWProxy get copyWith => _$ChatMessageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['_id'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : User.fromJson(json['receiver'] as Map<String, dynamic>),
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
      'type': instance.type,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'delivered': instance.delivered,
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'seen': instance.seen,
      'seenAt': instance.seenAt?.toIso8601String(),
      'deleted': instance.deleted,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

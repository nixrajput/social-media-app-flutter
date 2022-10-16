// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatMessageCWProxy {
  ChatMessage createdAt(DateTime? createdAt);

  ChatMessage delivered(bool? delivered);

  ChatMessage deliveredAt(DateTime? deliveredAt);

  ChatMessage id(String? id);

  ChatMessage mediaFile(PostMediaFile? mediaFile);

  ChatMessage message(String? message);

  ChatMessage receiver(User? receiver);

  ChatMessage receiverId(String? receiverId);

  ChatMessage replyTo(String? replyTo);

  ChatMessage seen(bool? seen);

  ChatMessage seenAt(DateTime? seenAt);

  ChatMessage sender(User? sender);

  ChatMessage senderId(String? senderId);

  ChatMessage sent(bool? sent);

  ChatMessage sentAt(DateTime? sentAt);

  ChatMessage tempId(String? tempId);

  ChatMessage updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChatMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChatMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  ChatMessage call({
    DateTime? createdAt,
    bool? delivered,
    DateTime? deliveredAt,
    String? id,
    PostMediaFile? mediaFile,
    String? message,
    User? receiver,
    String? receiverId,
    String? replyTo,
    bool? seen,
    DateTime? seenAt,
    User? sender,
    String? senderId,
    bool? sent,
    DateTime? sentAt,
    String? tempId,
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
  ChatMessage delivered(bool? delivered) => this(delivered: delivered);

  @override
  ChatMessage deliveredAt(DateTime? deliveredAt) =>
      this(deliveredAt: deliveredAt);

  @override
  ChatMessage id(String? id) => this(id: id);

  @override
  ChatMessage mediaFile(PostMediaFile? mediaFile) => this(mediaFile: mediaFile);

  @override
  ChatMessage message(String? message) => this(message: message);

  @override
  ChatMessage receiver(User? receiver) => this(receiver: receiver);

  @override
  ChatMessage receiverId(String? receiverId) => this(receiverId: receiverId);

  @override
  ChatMessage replyTo(String? replyTo) => this(replyTo: replyTo);

  @override
  ChatMessage seen(bool? seen) => this(seen: seen);

  @override
  ChatMessage seenAt(DateTime? seenAt) => this(seenAt: seenAt);

  @override
  ChatMessage sender(User? sender) => this(sender: sender);

  @override
  ChatMessage senderId(String? senderId) => this(senderId: senderId);

  @override
  ChatMessage sent(bool? sent) => this(sent: sent);

  @override
  ChatMessage sentAt(DateTime? sentAt) => this(sentAt: sentAt);

  @override
  ChatMessage tempId(String? tempId) => this(tempId: tempId);

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
    Object? delivered = const $CopyWithPlaceholder(),
    Object? deliveredAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? mediaFile = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? receiver = const $CopyWithPlaceholder(),
    Object? receiverId = const $CopyWithPlaceholder(),
    Object? replyTo = const $CopyWithPlaceholder(),
    Object? seen = const $CopyWithPlaceholder(),
    Object? seenAt = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
    Object? senderId = const $CopyWithPlaceholder(),
    Object? sent = const $CopyWithPlaceholder(),
    Object? sentAt = const $CopyWithPlaceholder(),
    Object? tempId = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return ChatMessage(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
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
      mediaFile: mediaFile == const $CopyWithPlaceholder()
          ? _value.mediaFile
          // ignore: cast_nullable_to_non_nullable
          : mediaFile as PostMediaFile?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      receiver: receiver == const $CopyWithPlaceholder()
          ? _value.receiver
          // ignore: cast_nullable_to_non_nullable
          : receiver as User?,
      receiverId: receiverId == const $CopyWithPlaceholder()
          ? _value.receiverId
          // ignore: cast_nullable_to_non_nullable
          : receiverId as String?,
      replyTo: replyTo == const $CopyWithPlaceholder()
          ? _value.replyTo
          // ignore: cast_nullable_to_non_nullable
          : replyTo as String?,
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
      senderId: senderId == const $CopyWithPlaceholder()
          ? _value.senderId
          // ignore: cast_nullable_to_non_nullable
          : senderId as String?,
      sent: sent == const $CopyWithPlaceholder()
          ? _value.sent
          // ignore: cast_nullable_to_non_nullable
          : sent as bool?,
      sentAt: sentAt == const $CopyWithPlaceholder()
          ? _value.sentAt
          // ignore: cast_nullable_to_non_nullable
          : sentAt as DateTime?,
      tempId: tempId == const $CopyWithPlaceholder()
          ? _value.tempId
          // ignore: cast_nullable_to_non_nullable
          : tempId as String?,
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
      tempId: json['tempId'] as String?,
      senderId: json['senderId'] as String?,
      receiverId: json['receiverId'] as String?,
      message: json['message'] as String?,
      mediaFile: json['mediaFile'] == null
          ? null
          : PostMediaFile.fromJson(json['mediaFile'] as Map<String, dynamic>),
      replyTo: json['replyTo'] as String?,
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : User.fromJson(json['receiver'] as Map<String, dynamic>),
      sent: json['sent'] as bool?,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      delivered: json['delivered'] as bool?,
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      seen: json['seen'] as bool?,
      seenAt: json['seenAt'] == null
          ? null
          : DateTime.parse(json['seenAt'] as String),
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
      'tempId': instance.tempId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'mediaFile': instance.mediaFile,
      'replyTo': instance.replyTo,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'sent': instance.sent,
      'sentAt': instance.sentAt?.toIso8601String(),
      'delivered': instance.delivered,
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'seen': instance.seen,
      'seenAt': instance.seenAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

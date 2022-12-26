// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatMessageCWProxy {
  ChatMessage id(String? id);

  ChatMessage tempId(String? tempId);

  ChatMessage senderId(String? senderId);

  ChatMessage receiverId(String? receiverId);

  ChatMessage message(String? message);

  ChatMessage mediaFile(PostMediaFile? mediaFile);

  ChatMessage replyTo(ChatMessage? replyTo);

  ChatMessage sender(User? sender);

  ChatMessage receiver(User? receiver);

  ChatMessage sent(bool? sent);

  ChatMessage sentAt(DateTime? sentAt);

  ChatMessage delivered(bool? delivered);

  ChatMessage deliveredAt(DateTime? deliveredAt);

  ChatMessage seen(bool? seen);

  ChatMessage seenAt(DateTime? seenAt);

  ChatMessage createdAt(DateTime? createdAt);

  ChatMessage updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChatMessage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChatMessage(...).copyWith(id: 12, name: "My name")
  /// ````
  ChatMessage call({
    String? id,
    String? tempId,
    String? senderId,
    String? receiverId,
    String? message,
    PostMediaFile? mediaFile,
    ChatMessage? replyTo,
    User? sender,
    User? receiver,
    bool? sent,
    DateTime? sentAt,
    bool? delivered,
    DateTime? deliveredAt,
    bool? seen,
    DateTime? seenAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChatMessage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChatMessage.copyWith.fieldName(...)`
class _$ChatMessageCWProxyImpl implements _$ChatMessageCWProxy {
  const _$ChatMessageCWProxyImpl(this._value);

  final ChatMessage _value;

  @override
  ChatMessage id(String? id) => this(id: id);

  @override
  ChatMessage tempId(String? tempId) => this(tempId: tempId);

  @override
  ChatMessage senderId(String? senderId) => this(senderId: senderId);

  @override
  ChatMessage receiverId(String? receiverId) => this(receiverId: receiverId);

  @override
  ChatMessage message(String? message) => this(message: message);

  @override
  ChatMessage mediaFile(PostMediaFile? mediaFile) => this(mediaFile: mediaFile);

  @override
  ChatMessage replyTo(ChatMessage? replyTo) => this(replyTo: replyTo);

  @override
  ChatMessage sender(User? sender) => this(sender: sender);

  @override
  ChatMessage receiver(User? receiver) => this(receiver: receiver);

  @override
  ChatMessage sent(bool? sent) => this(sent: sent);

  @override
  ChatMessage sentAt(DateTime? sentAt) => this(sentAt: sentAt);

  @override
  ChatMessage delivered(bool? delivered) => this(delivered: delivered);

  @override
  ChatMessage deliveredAt(DateTime? deliveredAt) =>
      this(deliveredAt: deliveredAt);

  @override
  ChatMessage seen(bool? seen) => this(seen: seen);

  @override
  ChatMessage seenAt(DateTime? seenAt) => this(seenAt: seenAt);

  @override
  ChatMessage createdAt(DateTime? createdAt) => this(createdAt: createdAt);

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
    Object? id = const $CopyWithPlaceholder(),
    Object? tempId = const $CopyWithPlaceholder(),
    Object? senderId = const $CopyWithPlaceholder(),
    Object? receiverId = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? mediaFile = const $CopyWithPlaceholder(),
    Object? replyTo = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
    Object? receiver = const $CopyWithPlaceholder(),
    Object? sent = const $CopyWithPlaceholder(),
    Object? sentAt = const $CopyWithPlaceholder(),
    Object? delivered = const $CopyWithPlaceholder(),
    Object? deliveredAt = const $CopyWithPlaceholder(),
    Object? seen = const $CopyWithPlaceholder(),
    Object? seenAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return ChatMessage(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      tempId: tempId == const $CopyWithPlaceholder()
          ? _value.tempId
          // ignore: cast_nullable_to_non_nullable
          : tempId as String?,
      senderId: senderId == const $CopyWithPlaceholder()
          ? _value.senderId
          // ignore: cast_nullable_to_non_nullable
          : senderId as String?,
      receiverId: receiverId == const $CopyWithPlaceholder()
          ? _value.receiverId
          // ignore: cast_nullable_to_non_nullable
          : receiverId as String?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      mediaFile: mediaFile == const $CopyWithPlaceholder()
          ? _value.mediaFile
          // ignore: cast_nullable_to_non_nullable
          : mediaFile as PostMediaFile?,
      replyTo: replyTo == const $CopyWithPlaceholder()
          ? _value.replyTo
          // ignore: cast_nullable_to_non_nullable
          : replyTo as ChatMessage?,
      sender: sender == const $CopyWithPlaceholder()
          ? _value.sender
          // ignore: cast_nullable_to_non_nullable
          : sender as User?,
      receiver: receiver == const $CopyWithPlaceholder()
          ? _value.receiver
          // ignore: cast_nullable_to_non_nullable
          : receiver as User?,
      sent: sent == const $CopyWithPlaceholder()
          ? _value.sent
          // ignore: cast_nullable_to_non_nullable
          : sent as bool?,
      sentAt: sentAt == const $CopyWithPlaceholder()
          ? _value.sentAt
          // ignore: cast_nullable_to_non_nullable
          : sentAt as DateTime?,
      delivered: delivered == const $CopyWithPlaceholder()
          ? _value.delivered
          // ignore: cast_nullable_to_non_nullable
          : delivered as bool?,
      deliveredAt: deliveredAt == const $CopyWithPlaceholder()
          ? _value.deliveredAt
          // ignore: cast_nullable_to_non_nullable
          : deliveredAt as DateTime?,
      seen: seen == const $CopyWithPlaceholder()
          ? _value.seen
          // ignore: cast_nullable_to_non_nullable
          : seen as bool?,
      seenAt: seenAt == const $CopyWithPlaceholder()
          ? _value.seenAt
          // ignore: cast_nullable_to_non_nullable
          : seenAt as DateTime?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
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
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = 11;

  @override
  ChatMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessage(
      id: fields[0] as String?,
      tempId: fields[1] as String?,
      senderId: fields[2] as String?,
      receiverId: fields[3] as String?,
      message: fields[4] as String?,
      mediaFile: fields[5] as PostMediaFile?,
      replyTo: fields[6] as ChatMessage?,
      sender: fields[7] as User?,
      receiver: fields[8] as User?,
      sent: fields[9] as bool?,
      sentAt: fields[10] as DateTime?,
      delivered: fields[11] as bool?,
      deliveredAt: fields[12] as DateTime?,
      seen: fields[13] as bool?,
      seenAt: fields[14] as DateTime?,
      createdAt: fields[15] as DateTime?,
      updatedAt: fields[16] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tempId)
      ..writeByte(2)
      ..write(obj.senderId)
      ..writeByte(3)
      ..write(obj.receiverId)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.mediaFile)
      ..writeByte(6)
      ..write(obj.replyTo)
      ..writeByte(7)
      ..write(obj.sender)
      ..writeByte(8)
      ..write(obj.receiver)
      ..writeByte(9)
      ..write(obj.sent)
      ..writeByte(10)
      ..write(obj.sentAt)
      ..writeByte(11)
      ..write(obj.delivered)
      ..writeByte(12)
      ..write(obj.deliveredAt)
      ..writeByte(13)
      ..write(obj.seen)
      ..writeByte(14)
      ..write(obj.seenAt)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
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
      replyTo: json['replyTo'] == null
          ? null
          : ChatMessage.fromJson(json['replyTo'] as Map<String, dynamic>),
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

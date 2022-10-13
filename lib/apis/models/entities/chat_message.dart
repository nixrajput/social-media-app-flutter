import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'chat_message.g.dart';

@CopyWith()
@JsonSerializable()
class ChatMessage {
  ChatMessage({
    this.id,
    this.tempId,
    this.senderId,
    this.receiverId,
    this.message,
    this.type,
    this.sender,
    this.receiver,
    this.sent,
    this.sentAt,
    this.delivered,
    this.deliveredAt,
    this.seen,
    this.seenAt,
    this.deleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'tempId')
  final String? tempId;

  @JsonKey(name: 'senderId')
  final String? senderId;

  @JsonKey(name: 'receiverId')
  final String? receiverId;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'sender')
  final User? sender;

  @JsonKey(name: 'receiver')
  final User? receiver;

  @JsonKey(name: 'sent')
  bool? sent;

  @JsonKey(name: 'sentAt')
  DateTime? sentAt;

  @JsonKey(name: 'delivered')
  bool? delivered;

  @JsonKey(name: 'deliveredAt')
  DateTime? deliveredAt;

  @JsonKey(name: 'seen')
  bool? seen;

  @JsonKey(name: 'seenAt')
  DateTime? seenAt;

  @JsonKey(name: 'deleted')
  bool? deleted;

  @JsonKey(name: 'deletedAt')
  DateTime? deletedAt;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
}

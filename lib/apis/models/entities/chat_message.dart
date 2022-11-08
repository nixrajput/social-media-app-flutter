import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'chat_message.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.chatMessage)
class ChatMessage {
  ChatMessage({
    this.id,
    this.tempId,
    this.senderId,
    this.receiverId,
    this.message,
    this.mediaFile,
    this.replyTo,
    this.sender,
    this.receiver,
    this.sent,
    this.sentAt,
    this.delivered,
    this.deliveredAt,
    this.seen,
    this.seenAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'tempId')
  @HiveField(1)
  final String? tempId;

  @JsonKey(name: 'senderId')
  @HiveField(2)
  final String? senderId;

  @JsonKey(name: 'receiverId')
  @HiveField(3)
  final String? receiverId;

  @JsonKey(name: 'message')
  @HiveField(4)
  final String? message;

  @JsonKey(name: 'mediaFile')
  @HiveField(5)
  final PostMediaFile? mediaFile;

  @JsonKey(name: 'replyTo')
  @HiveField(6)
  final ChatMessage? replyTo;

  @JsonKey(name: 'sender')
  @HiveField(7)
  final User? sender;

  @JsonKey(name: 'receiver')
  @HiveField(8)
  final User? receiver;

  @JsonKey(name: 'sent')
  @HiveField(9)
  bool? sent;

  @JsonKey(name: 'sentAt')
  @HiveField(10)
  DateTime? sentAt;

  @JsonKey(name: 'delivered')
  @HiveField(11)
  bool? delivered;

  @JsonKey(name: 'deliveredAt')
  @HiveField(12)
  DateTime? deliveredAt;

  @JsonKey(name: 'seen')
  @HiveField(13)
  bool? seen;

  @JsonKey(name: 'seenAt')
  @HiveField(14)
  DateTime? seenAt;

  @JsonKey(name: 'createdAt')
  @HiveField(15)
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(16)
  final DateTime? updatedAt;
}

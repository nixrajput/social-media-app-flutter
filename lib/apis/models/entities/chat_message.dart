import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  const ChatMessage({
    this.id,
    this.message,
    this.type,
    this.sender,
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

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'type ')
  final String? type;

  @JsonKey(name: 'sender')
  final User? sender;

  @JsonKey(name: 'delivered')
  final bool? delivered;

  @JsonKey(name: 'deliveredAt')
  final DateTime? deliveredAt;

  @JsonKey(name: 'seen')
  final bool? seen;

  @JsonKey(name: 'seenAt')
  final DateTime? seenAt;

  @JsonKey(name: 'deleted')
  final bool? deleted;

  @JsonKey(name: 'deletedAt')
  final DateTime? deletedAt;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
}

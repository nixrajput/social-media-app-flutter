import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'notification.g.dart';

@JsonSerializable()
class ApiNotification {
  ApiNotification({
    required this.id,
    required this.owner,
    required this.user,
    required this.body,
    this.refId,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory ApiNotification.fromJson(Map<String, dynamic> json) =>
      _$ApiNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$ApiNotificationToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'owner')
  User owner;

  @JsonKey(name: 'user')
  User user;

  @JsonKey(name: 'body')
  String body;

  @JsonKey(name: 'refId')
  String? refId;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'isRead')
  bool isRead;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;
}

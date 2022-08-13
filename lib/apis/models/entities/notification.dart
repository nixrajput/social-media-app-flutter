import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'notification.g.dart';

@JsonSerializable()
class ApiNotification extends Equatable {
  const ApiNotification({
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
  final String id;

  @JsonKey(name: 'owner')
  final User owner;

  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'body')
  final String body;

  @JsonKey(name: 'refId')
  final String? refId;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'isRead')
  final bool isRead;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        owner,
        user,
        body,
        refId,
        type,
        isRead,
        createdAt,
      ];
}

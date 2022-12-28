import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'notification.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.notification)
class NotificationModel {
  NotificationModel({
    required this.id,
    required this.to,
    required this.from,
    required this.body,
    this.refId,
    required this.type,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  String id;

  @JsonKey(name: 'to')
  @HiveField(1)
  User to;

  @JsonKey(name: 'from')
  @HiveField(2)
  User from;

  @JsonKey(name: 'body')
  @HiveField(3)
  String body;

  @JsonKey(name: 'refId')
  @HiveField(4)
  String? refId;

  @JsonKey(name: 'type')
  @HiveField(5)
  String type;

  @JsonKey(name: 'isRead')
  @HiveField(6)
  bool isRead;

  @JsonKey(name: 'createdAt')
  @HiveField(7)
  DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(8)
  DateTime updatedAt;
}

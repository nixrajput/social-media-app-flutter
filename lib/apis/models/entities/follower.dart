import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'follower.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.follower)
class Follower extends HiveObject {
  Follower({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  final String id;

  @JsonKey(name: 'user')
  @HiveField(1)
  final User user;

  @JsonKey(name: 'createdAt')
  @HiveField(2)
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(3)
  final DateTime updatedAt;
}

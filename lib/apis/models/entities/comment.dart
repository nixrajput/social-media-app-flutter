import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'comment.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.comment)
class Comment {
  Comment({
    required this.id,
    required this.comment,
    required this.user,
    required this.post,
    required this.likesCount,
    required this.commentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  final String id;

  @JsonKey(name: 'comment')
  @HiveField(1)
  final String comment;

  @JsonKey(name: 'post')
  @HiveField(2)
  final String post;

  @JsonKey(name: 'user')
  @HiveField(3)
  final User user;

  @JsonKey(name: 'likesCount')
  @HiveField(4)
  int likesCount;

  @JsonKey(name: 'commentStatus')
  @HiveField(5)
  String commentStatus;

  @JsonKey(name: 'createdAt')
  @HiveField(6)
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(7)
  final DateTime updatedAt;
}

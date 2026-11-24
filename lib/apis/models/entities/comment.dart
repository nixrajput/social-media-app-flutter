import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'comment.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.comment)
class Comment {
  Comment({
    this.id,
    this.type,
    this.comment,
    this.user,
    this.post,
    this.likesCount,
    this.repliesCount,
    this.isLiked,
    this.allowLikes,
    this.allowReplies,
    this.visibility,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  String? id;

  @JsonKey(name: 'type')
  @HiveField(1)
  String? type;

  @JsonKey(name: 'comment')
  @HiveField(2)
  String? comment;

  @JsonKey(name: 'post')
  @HiveField(3)
  String? post;

  @JsonKey(name: 'user')
  @HiveField(4)
  User? user;

  @JsonKey(name: 'likesCount')
  @HiveField(5)
  int? likesCount;

  @JsonKey(name: 'repliesCount')
  @HiveField(6)
  int? repliesCount;

  @JsonKey(name: 'isLiked')
  @HiveField(7)
  bool? isLiked;

  @JsonKey(name: 'allowLikes')
  @HiveField(8)
  bool? allowLikes;

  @JsonKey(name: 'allowReplies')
  @HiveField(9)
  bool? allowReplies;

  @JsonKey(name: 'visibility')
  @HiveField(10)
  String? visibility;

  @JsonKey(name: 'status')
  @HiveField(11)
  String? status;

  @JsonKey(name: 'createdAt')
  @HiveField(12)
  DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(13)
  DateTime? updatedAt;
}

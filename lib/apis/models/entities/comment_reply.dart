import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'comment_reply.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.comment)
class CommentReply {
  CommentReply({
    this.id,
    this.reply,
    this.comment,
    this.user,
    this.post,
    this.likesCount,
    this.isLiked,
    this.allowLikes,
    this.visibility,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CommentReply.fromJson(Map<String, dynamic> json) =>
      _$CommentReplyFromJson(json);

  Map<String, dynamic> toJson() => _$CommentReplyToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  String? id;

  @JsonKey(name: 'reply')
  @HiveField(1)
  String? reply;

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

  @JsonKey(name: 'isLiked')
  @HiveField(6)
  bool? isLiked;

  @JsonKey(name: 'allowLikes')
  @HiveField(7)
  bool? allowLikes;

  @JsonKey(name: 'visibility')
  @HiveField(8)
  String? visibility;

  @JsonKey(name: 'status')
  @HiveField(9)
  String? status;

  @JsonKey(name: 'createdAt')
  @HiveField(10)
  DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(11)
  DateTime? updatedAt;
}

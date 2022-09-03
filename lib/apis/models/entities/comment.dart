import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  Comment({
    required this.id,
    required this.comment,
    required this.user,
    required this.post,
    required this.likesCount,
    required this.commentStatus,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'comment')
  final String comment;

  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'post')
  final String post;

  @JsonKey(name: 'likesCount')
  int likesCount;

  @JsonKey(name: 'commentStatus')
  String commentStatus;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
}

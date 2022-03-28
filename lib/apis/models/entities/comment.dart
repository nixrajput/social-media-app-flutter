import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  Comment({
    required this.id,
    required this.comment,
    required this.user,
    required this.post,
    required this.likes,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'comment')
  final String comment;

  @JsonKey(name: 'user')
  final String user;

  @JsonKey(name: 'post')
  final String post;

  @JsonKey(name: 'likes')
  final List<dynamic> likes;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
}

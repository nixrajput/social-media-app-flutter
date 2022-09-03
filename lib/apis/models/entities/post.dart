import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  Post({
    this.id,
    this.caption,
    this.mediaFiles,
    required this.owner,
    required this.likesCount,
    required this.isLiked,
    required this.commentsCount,
    required this.postStatus,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'caption')
  final String? caption;

  @JsonKey(name: 'mediaFiles')
  final List<PostMediaFile>? mediaFiles;

  @JsonKey(name: 'owner')
  final User owner;

  @JsonKey(name: 'likesCount')
  int likesCount;

  @JsonKey(name: 'commentsCount')
  int commentsCount;

  @JsonKey(name: 'isLiked')
  bool isLiked;

  @JsonKey(name: 'postStatus')
  String postStatus;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
}

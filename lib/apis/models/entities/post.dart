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
    required this.hashtags,
    required this.userMentions,
    required this.postType,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    required this.isArchived,
    required this.visibility,
    required this.allowComments,
    required this.allowLikes,
    required this.allowReposts,
    required this.allowShare,
    required this.allowSave,
    required this.allowDownload,
    required this.postStatus,
    required this.createdAt,
    required this.updatedAt,
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

  @JsonKey(name: 'hashtags')
  final List<String> hashtags;

  @JsonKey(name: 'userMentions')
  final List<String> userMentions;

  @JsonKey(name: 'postType')
  final String postType;

  @JsonKey(name: 'likesCount')
  int likesCount;

  @JsonKey(name: 'commentsCount')
  int commentsCount;

  @JsonKey(name: 'isLiked')
  bool isLiked;

  @JsonKey(name: 'isArchived')
  bool isArchived;

  @JsonKey(name: 'visibility')
  String visibility;

  @JsonKey(name: 'allowComments')
  bool allowComments;

  @JsonKey(name: 'allowLikes')
  bool allowLikes;

  @JsonKey(name: 'allowReposts')
  bool allowReposts;

  @JsonKey(name: 'allowShare')
  bool allowShare;

  @JsonKey(name: 'allowSave')
  bool allowSave;

  @JsonKey(name: 'allowDownload')
  bool allowDownload;

  @JsonKey(name: 'postStatus')
  String postStatus;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
}

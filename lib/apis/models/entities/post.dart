import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'post.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.post)
class Post extends HiveObject {
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
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'caption')
  @HiveField(1)
  final String? caption;

  @JsonKey(name: 'mediaFiles')
  @HiveField(2)
  final List<PostMediaFile>? mediaFiles;

  @JsonKey(name: 'owner')
  @HiveField(3)
  final User owner;

  @JsonKey(name: 'hashtags')
  @HiveField(4)
  final List<String> hashtags;

  @JsonKey(name: 'userMentions')
  @HiveField(5)
  final List<String> userMentions;

  @JsonKey(name: 'postType')
  @HiveField(6)
  final String postType;

  @JsonKey(name: 'likesCount')
  @HiveField(7)
  int likesCount;

  @JsonKey(name: 'commentsCount')
  @HiveField(8)
  int commentsCount;

  @JsonKey(name: 'isLiked')
  @HiveField(9)
  bool isLiked;

  @JsonKey(name: 'isArchived')
  @HiveField(10)
  bool isArchived;

  @JsonKey(name: 'visibility')
  @HiveField(11)
  String visibility;

  @JsonKey(name: 'allowComments')
  @HiveField(12)
  bool allowComments;

  @JsonKey(name: 'allowLikes')
  @HiveField(13)
  bool allowLikes;

  @JsonKey(name: 'allowReposts')
  @HiveField(14)
  bool allowReposts;

  @JsonKey(name: 'allowShare')
  @HiveField(15)
  bool allowShare;

  @JsonKey(name: 'allowSave')
  @HiveField(16)
  bool allowSave;

  @JsonKey(name: 'allowDownload')
  @HiveField(17)
  bool allowDownload;

  @JsonKey(name: 'postStatus')
  @HiveField(18)
  String postStatus;

  @JsonKey(name: 'createdAt')
  @HiveField(19)
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(20)
  final DateTime updatedAt;
}

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/poll_option.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'post.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.post)
class Post {
  Post({
    this.id,
    this.postType,
    this.caption,
    this.mediaFiles,
    this.pollQuestion,
    this.pollOptions,
    this.pollEndsAt,
    this.totalVotes,
    this.owner,
    this.hashtags,
    this.userMentions,
    this.likesCount,
    this.commentsCount,
    this.repostsCount,
    this.sharesCount,
    this.savesCount,
    this.isLiked,
    this.isVoted,
    this.allowComments,
    this.allowLikes,
    this.allowReposts,
    this.allowShare,
    this.allowSave,
    this.allowDownload,
    this.visibility,
    this.postStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  String? id;

  @JsonKey(name: 'postType')
  @HiveField(1)
  String? postType;

  @JsonKey(name: 'caption')
  @HiveField(2)
  String? caption;

  @JsonKey(name: 'mediaFiles')
  @HiveField(3)
  List<PostMediaFile>? mediaFiles;

  @JsonKey(name: 'pollQuestion')
  @HiveField(4)
  String? pollQuestion;

  @JsonKey(name: 'pollOptions')
  @HiveField(5)
  List<PollOption>? pollOptions;

  @JsonKey(name: 'pollEndsAt')
  @HiveField(6)
  DateTime? pollEndsAt;

  @JsonKey(name: 'totalVotes')
  @HiveField(7)
  int? totalVotes;

  @JsonKey(name: 'owner')
  @HiveField(8)
  User? owner;

  @JsonKey(name: 'hashtags')
  @HiveField(9)
  List<String>? hashtags;

  @JsonKey(name: 'userMentions')
  @HiveField(10)
  List<String>? userMentions;

  @JsonKey(name: 'likesCount')
  @HiveField(11)
  int? likesCount;

  @JsonKey(name: 'commentsCount')
  @HiveField(12)
  int? commentsCount;

  @JsonKey(name: 'repostsCount')
  @HiveField(13)
  int? repostsCount;

  @JsonKey(name: 'sharesCount')
  @HiveField(14)
  int? sharesCount;

  @JsonKey(name: 'savesCount')
  @HiveField(15)
  int? savesCount;

  @JsonKey(name: 'isLiked')
  @HiveField(16)
  bool? isLiked;

  @JsonKey(name: 'isVoted')
  @HiveField(17)
  bool? isVoted;

  @JsonKey(name: 'allowComments')
  @HiveField(18)
  bool? allowComments;

  @JsonKey(name: 'allowLikes')
  @HiveField(19)
  bool? allowLikes;

  @JsonKey(name: 'allowReposts')
  @HiveField(20)
  bool? allowReposts;

  @JsonKey(name: 'allowShare')
  @HiveField(21)
  bool? allowShare;

  @JsonKey(name: 'allowSave')
  @HiveField(22)
  bool? allowSave;

  @JsonKey(name: 'allowDownload')
  @HiveField(23)
  bool? allowDownload;

  @JsonKey(name: 'visibility')
  @HiveField(24)
  String? visibility;

  @JsonKey(name: 'postStatus')
  @HiveField(25)
  String? postStatus;

  @JsonKey(name: 'createdAt')
  @HiveField(26)
  DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(27)
  DateTime? updatedAt;

  @JsonKey(name: 'votedOption')
  @HiveField(28)
  String? votedOption;
}

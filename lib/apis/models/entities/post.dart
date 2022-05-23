import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post_image.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  Post({
    required this.id,
    this.caption,
    this.images,
    this.mediaFiles,
    required this.owner,
    required this.likes,
    required this.comments,
    required this.postStatus,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'caption')
  String? caption;

  @JsonKey(name: 'images')
  List<PostImage>? images;

  @JsonKey(name: 'mediaFiles')
  List<PostMediaFile>? mediaFiles;

  @JsonKey(name: 'owner')
  User owner;

  @JsonKey(name: 'likes')
  List<dynamic> likes;

  @JsonKey(name: 'comments')
  List<dynamic> comments;

  @JsonKey(name: 'postStatus')
  String postStatus;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;
}

import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post_image.dart';

part 'user_post.g.dart';

@JsonSerializable()
class UserPost {
  UserPost({
    required this.id,
    this.caption,
    this.images,
    required this.owner,
    required this.likes,
    required this.comments,
    required this.postStatus,
    required this.createdAt,
  });

  factory UserPost.fromJson(Map<String, dynamic> json) =>
      _$UserPostFromJson(json);

  Map<String, dynamic> toJson() => _$UserPostToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'caption')
  String? caption;

  @JsonKey(name: 'images')
  List<PostImage>? images;

  @JsonKey(name: 'owner')
  String owner;

  @JsonKey(name: 'likes')
  List<dynamic> likes;

  @JsonKey(name: 'comments')
  List<dynamic> comments;

  @JsonKey(name: 'postStatus')
  String postStatus;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;
}

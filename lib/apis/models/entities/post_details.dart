import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/apis/models/entities/post_image.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'post_details.g.dart';

@JsonSerializable()
class PostDetails {
  PostDetails({
    required this.id,
    this.caption,
    this.images,
    required this.owner,
    required this.likes,
    required this.comments,
    required this.postStatus,
    required this.createdAt,
  });

  factory PostDetails.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PostDetailsToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'caption')
  String? caption;

  @JsonKey(name: 'images')
  List<PostImage>? images;

  @JsonKey(name: 'owner')
  User owner;

  @JsonKey(name: 'likes')
  List<dynamic> likes;

  @JsonKey(name: 'comments')
  List<Comment> comments;

  @JsonKey(name: 'postStatus')
  String postStatus;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;
}

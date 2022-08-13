import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post_image.dart';

part 'user_post.g.dart';

@JsonSerializable()
class UserPost extends Equatable {
  const UserPost({
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
  final String id;

  @JsonKey(name: 'caption')
  final String? caption;

  @JsonKey(name: 'images')
  final List<PostImage>? images;

  @JsonKey(name: 'owner')
  final String owner;

  @JsonKey(name: 'likes')
  final List<dynamic> likes;

  @JsonKey(name: 'comments')
  final List<dynamic> comments;

  @JsonKey(name: 'postStatus')
  final String postStatus;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        caption,
        images,
        owner,
        likes,
        comments,
        postStatus,
        createdAt,
      ];
}

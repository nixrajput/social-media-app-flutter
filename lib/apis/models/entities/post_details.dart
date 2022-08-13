import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/apis/models/entities/post_image.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'post_details.g.dart';

@JsonSerializable()
class PostDetails extends Equatable {
  const PostDetails({
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
  final String id;

  @JsonKey(name: 'caption')
  final String? caption;

  @JsonKey(name: 'images')
  final List<PostImage>? images;

  @JsonKey(name: 'owner')
  final User owner;

  @JsonKey(name: 'likes')
  final List<dynamic> likes;

  @JsonKey(name: 'comments')
  final List<Comment> comments;

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

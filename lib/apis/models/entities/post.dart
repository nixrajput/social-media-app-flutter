import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  const Post({
    required this.id,
    this.caption,
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
  final String id;

  @JsonKey(name: 'caption')
  final String? caption;

  @JsonKey(name: 'mediaFiles')
  final List<PostMediaFile>? mediaFiles;

  @JsonKey(name: 'owner')
  final User owner;

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
        mediaFiles,
        owner,
        likes,
        comments,
        postStatus,
        createdAt,
      ];
}

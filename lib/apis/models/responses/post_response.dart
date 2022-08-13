import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse extends Equatable {
  const PostResponse({
    this.success,
    this.count,
    this.posts,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'posts')
  final List<Post>? posts;

  @override
  List<Object?> get props => <Object?>[
        success,
        count,
        posts,
      ];
}

import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  PostResponse({
    this.success,
    this.count,
    this.posts,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'posts')
  List<Post>? posts;
}

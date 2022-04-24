import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';

part 'comments_response.g.dart';

@JsonSerializable()
class CommentsResponse {
  CommentsResponse({
    this.success,
    this.count,
    this.comments,
  });

  factory CommentsResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'comments')
  List<Comment>? comments;
}

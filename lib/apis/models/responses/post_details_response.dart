import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post_details.dart';

part 'post_details_response.g.dart';

@JsonSerializable()
class PostDetailsResponse {
  PostDetailsResponse({
    this.success,
    this.post,
  });

  factory PostDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostDetailsResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'post')
  PostDetails? post;
}

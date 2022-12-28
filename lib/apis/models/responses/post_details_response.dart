import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/post.dart';

part 'post_details_response.g.dart';

@JsonSerializable()
class PostDetailsResponse extends Equatable {
  const PostDetailsResponse({
    this.success,
    this.post,
  });

  factory PostDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostDetailsResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'post')
  final Post? post;

  @override
  List<Object?> get props => <Object?>[
        success,
        post,
      ];
}

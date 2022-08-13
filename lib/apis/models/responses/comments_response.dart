import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';

part 'comments_response.g.dart';

@JsonSerializable()
class CommentsResponse extends Equatable {
  const CommentsResponse({
    this.success,
    this.count,
    this.comments,
  });

  factory CommentsResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'comments')
  final List<Comment>? comments;

  @override
  List<Object?> get props => <Object?>[
        success,
        count,
        comments,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_like.g.dart';

@JsonSerializable()
class PostLike extends Equatable {
  const PostLike({
    this.id,
    this.likedBy,
    this.likedAt,
  });

  factory PostLike.fromJson(Map<String, dynamic> json) =>
      _$PostLikeFromJson(json);

  Map<String, dynamic> toJson() => _$PostLikeToJson(this);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'likedBy')
  final String? likedBy;

  @JsonKey(name: 'likedAt')
  final DateTime? likedAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        likedBy,
        likedAt,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'post_like_details.g.dart';

@JsonSerializable()
class PostLikeDetails extends Equatable {
  const PostLikeDetails({
    this.id,
    this.likedBy,
    this.likedAt,
  });

  factory PostLikeDetails.fromJson(Map<String, dynamic> json) =>
      _$PostLikeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PostLikeDetailsToJson(this);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'likedBy')
  final User? likedBy;

  @JsonKey(name: 'likedAt')
  final DateTime? likedAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        likedBy,
        likedAt,
      ];
}

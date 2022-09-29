import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'like_details.g.dart';

@CopyWith()
@JsonSerializable()
class LikeDetails extends Equatable {
  const LikeDetails({
    this.id,
    this.likedBy,
    this.likedAt,
  });

  factory LikeDetails.fromJson(Map<String, dynamic> json) =>
      _$LikeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LikeDetailsToJson(this);

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

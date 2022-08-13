import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_image.g.dart';

@JsonSerializable()
class PostImage extends Equatable {
  const PostImage({
    this.id,
    this.publicId,
    this.url,
  });

  factory PostImage.fromJson(Map<String, dynamic> json) =>
      _$PostImageFromJson(json);

  Map<String, dynamic> toJson() => _$PostImageToJson(this);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'public_id')
  final String? publicId;

  @JsonKey(name: 'url')
  final String? url;

  @override
  List<Object?> get props => <Object?>[
        id,
        publicId,
        url,
      ];
}

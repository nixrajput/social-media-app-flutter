import 'package:json_annotation/json_annotation.dart';

part 'post_image.g.dart';

@JsonSerializable()
class PostImage {
  PostImage({
    this.id,
    this.publicId,
    this.url,
  });

  factory PostImage.fromJson(Map<String, dynamic> json) =>
      _$PostImageFromJson(json);

  Map<String, dynamic> toJson() => _$PostImageToJson(this);

  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'public_id')
  String? publicId;

  @JsonKey(name: 'url')
  String? url;
}

import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media {
  Media({
    this.publicId,
    this.url,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);

  @JsonKey(name: 'public_id')
  String? publicId;

  @JsonKey(name: 'url')
  String? url;
}

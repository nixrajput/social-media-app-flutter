import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/media.dart';

part 'post_media_file.g.dart';

@JsonSerializable()
class PostMediaFile {
  PostMediaFile({
    this.id,
    this.link,
    this.mediaType,
  });

  factory PostMediaFile.fromJson(Map<String, dynamic> json) =>
      _$PostMediaFileFromJson(json);

  Map<String, dynamic> toJson() => _$PostMediaFileToJson(this);

  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'link')
  Media? link;

  @JsonKey(name: 'mediaType')
  String? mediaType;
}

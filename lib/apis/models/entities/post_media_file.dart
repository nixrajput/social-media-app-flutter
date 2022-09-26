import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'post_media_file.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypeId.postMediaFle)
class PostMediaFile extends HiveObject {
  PostMediaFile({
    this.id,
    this.publicId,
    this.url,
    this.mediaType,
    this.thumbnail,
  });

  factory PostMediaFile.fromJson(Map<String, dynamic> json) =>
      _$PostMediaFileFromJson(json);

  Map<String, dynamic> toJson() => _$PostMediaFileToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'public_id')
  @HiveField(1)
  final String? publicId;

  @JsonKey(name: 'url')
  @HiveField(2)
  final String? url;

  @JsonKey(name: 'mediaType')
  @HiveField(3)
  final String? mediaType;

  @JsonKey(name: 'thumbnail')
  @HiveField(4)
  final MediaFile? thumbnail;
}

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'media_file.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.mediaFile)
class MediaFile {
  MediaFile({
    this.publicId,
    this.url,
  });

  factory MediaFile.fromJson(Map<String, dynamic> json) =>
      _$MediaFileFromJson(json);

  Map<String, dynamic> toJson() => _$MediaFileToJson(this);

  @JsonKey(name: 'public_id')
  @HiveField(0)
  final String? publicId;

  @JsonKey(name: 'url')
  @HiveField(1)
  final String? url;
}

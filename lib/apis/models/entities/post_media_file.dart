import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_media_file.g.dart';

@JsonSerializable()
class PostMediaFile extends Equatable {
  const PostMediaFile({
    this.id,
    this.publicId,
    this.url,
    this.mediaType,
  });

  factory PostMediaFile.fromJson(Map<String, dynamic> json) =>
      _$PostMediaFileFromJson(json);

  Map<String, dynamic> toJson() => _$PostMediaFileToJson(this);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'public_id')
  final String? publicId;

  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'mediaType')
  final String? mediaType;

  @override
  List<Object?> get props => <Object?>[
        id,
        publicId,
        url,
        mediaType,
      ];
}

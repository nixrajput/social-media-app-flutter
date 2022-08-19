import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';

part 'post_media_file.g.dart';

@JsonSerializable()
class PostMediaFile extends Equatable {
  const PostMediaFile({
    this.id,
    this.link,
    this.mediaType,
  });

  factory PostMediaFile.fromJson(Map<String, dynamic> json) =>
      _$PostMediaFileFromJson(json);

  Map<String, dynamic> toJson() => _$PostMediaFileToJson(this);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'link')
  final MediaFile? link;

  @JsonKey(name: 'mediaType')
  final String? mediaType;

  @override
  List<Object?> get props => <Object?>[
        id,
        link,
        mediaType,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_file.g.dart';

@JsonSerializable()
class MediaFile extends Equatable {
  const MediaFile({
    this.publicId,
    this.url,
  });

  factory MediaFile.fromJson(Map<String, dynamic> json) =>
      _$MediaFileFromJson(json);

  Map<String, dynamic> toJson() => _$MediaFileToJson(this);

  @JsonKey(name: 'public_id')
  final String? publicId;

  @JsonKey(name: 'url')
  final String? url;

  @override
  List<Object?> get props => <Object?>[
        publicId,
        url,
      ];
}

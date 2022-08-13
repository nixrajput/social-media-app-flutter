import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media extends Equatable {
  const Media({
    this.publicId,
    this.url,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);

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

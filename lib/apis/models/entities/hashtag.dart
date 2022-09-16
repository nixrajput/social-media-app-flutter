import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hashtag.g.dart';

@JsonSerializable()
class HashTag extends Equatable {
  const HashTag({
    this.id,
    this.name,
    this.postsCount,
  });

  factory HashTag.fromJson(Map<String, dynamic> json) =>
      _$HashTagFromJson(json);

  Map<String, dynamic> toJson() => _$HashTagToJson(this);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'postsCount')
  final int? postsCount;

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        postsCount,
      ];
}

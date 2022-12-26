import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'poll_option.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.pollOption)
class PollOption {
  PollOption({
    this.id,
    this.post,
    this.option,
    this.votes,
    this.createdAt,
    this.updatedAt,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) =>
      _$PollOptionFromJson(json);

  Map<String, dynamic> toJson() => _$PollOptionToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  String? id;

  @JsonKey(name: 'post')
  @HiveField(1)
  String? post;

  @JsonKey(name: 'option')
  @HiveField(2)
  String? option;

  @JsonKey(name: 'votes')
  @HiveField(3)
  int? votes;

  @JsonKey(name: 'createdAt')
  @HiveField(4)
  DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(5)
  DateTime? updatedAt;
}

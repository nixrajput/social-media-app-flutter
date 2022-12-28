import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'follow_request.g.dart';

@CopyWith()
@JsonSerializable()
class FollowRequest {
  FollowRequest({
    required this.id,
    required this.to,
    required this.from,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FollowRequest.fromJson(Map<String, dynamic> json) =>
      _$FollowRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FollowRequestToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'to')
  User to;

  @JsonKey(name: 'from')
  User from;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  DateTime updatedAt;
}

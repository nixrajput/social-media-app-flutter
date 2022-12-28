import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'online_user.g.dart';

@CopyWith()
@JsonSerializable()
class OnlineUser {
  OnlineUser({
    this.userId,
    this.status,
    this.lastSeen,
  });

  factory OnlineUser.fromJson(Map<String, dynamic> json) =>
      _$OnlineUserFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineUserToJson(this);

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'lastSeen')
  final String? lastSeen;
}

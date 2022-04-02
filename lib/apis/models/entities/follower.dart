import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user_avatar.dart';

part 'follower.g.dart';

@JsonSerializable()
class Follower {
  Follower({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
    this.avatar,
  });

  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'fname')
  String fname;

  @JsonKey(name: 'lname')
  String lname;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'uname')
  String uname;

  @JsonKey(name: 'avatar')
  UserAvatar? avatar;
}

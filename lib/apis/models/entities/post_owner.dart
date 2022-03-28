import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user_avatar.dart';

part 'post_owner.g.dart';

@JsonSerializable()
class PostOwner {
  PostOwner({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
    this.avatar,
  });

  factory PostOwner.fromJson(Map<String, dynamic> json) =>
      _$PostOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$PostOwnerToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'fname')
  final String fname;

  @JsonKey(name: 'lname')
  final String lname;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'uname')
  final String uname;

  @JsonKey(name: 'avatar')
  UserAvatar? avatar;
}

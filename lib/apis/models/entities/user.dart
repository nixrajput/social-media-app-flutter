import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user_avatar.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
    this.profession,
    this.avatar,
    required this.accountType,
    required this.accountStatus,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

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

  @JsonKey(name: 'profession')
  String? profession;

  @JsonKey(name: 'avatar')
  UserAvatar? avatar;

  @JsonKey(name: 'accountType')
  String accountType;

  @JsonKey(name: 'accountStatus')
  String accountStatus;

  @JsonKey(name: 'isVerified')
  bool isVerified;
}

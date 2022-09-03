import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';

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
    required this.accountPrivacy,
    required this.followingStatus,
    required this.accountStatus,
    required this.isVerified,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

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

  @JsonKey(name: 'profession')
  final String? profession;

  @JsonKey(name: 'avatar')
  final MediaFile? avatar;

  @JsonKey(name: 'accountPrivacy')
  String accountPrivacy;

  @JsonKey(name: 'followingStatus')
  String followingStatus;

  @JsonKey(name: 'accountStatus')
  final String accountStatus;

  @JsonKey(name: 'isVerified')
  bool isVerified;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
}

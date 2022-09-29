import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/apis/models/entities/server_key.dart';

part 'user_details.g.dart';

@CopyWith()
@JsonSerializable()
class UserDetails {
  UserDetails({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
    this.avatar,
    this.gender,
    this.dob,
    this.about,
    this.website,
    this.profession,
    required this.followersCount,
    required this.followingCount,
    required this.followingStatus,
    required this.postsCount,
    required this.accountStatus,
    required this.isPrivate,
    required this.isValid,
    required this.isVerified,
    required this.role,
    this.deviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);

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
  final MediaFile? avatar;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'dob')
  final String? dob;

  @JsonKey(name: 'about')
  final String? about;

  @JsonKey(name: 'profession')
  final String? profession;

  @JsonKey(name: 'website')
  final String? website;

  @JsonKey(name: 'postsCount')
  int postsCount;

  @JsonKey(name: 'followersCount')
  int followersCount;

  @JsonKey(name: 'followingCount')
  int followingCount;

  @JsonKey(name: 'followingStatus')
  String followingStatus;

  @JsonKey(name: 'accountStatus')
  final String accountStatus;

  @JsonKey(name: 'isPrivate')
  bool isPrivate;

  @JsonKey(name: 'isValid')
  final bool isValid;

  @JsonKey(name: 'isVerified')
  final bool isVerified;

  @JsonKey(name: 'role')
  final String role;

  @JsonKey(name: 'deviceId')
  String? deviceId;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
}

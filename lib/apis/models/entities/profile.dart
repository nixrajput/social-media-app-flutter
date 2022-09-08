import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.emailVerified,
    required this.uname,
    this.avatar,
    this.phone,
    this.countryCode,
    this.phoneVerified,
    this.gender,
    this.dob,
    this.about,
    this.profession,
    this.location,
    this.website,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    required this.role,
    required this.accountPrivacy,
    required this.accountStatus,
    required this.verificationStatus,
    required this.isValid,
    required this.isVerified,
    required this.createdAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'fname')
  String fname;

  @JsonKey(name: 'lname')
  String lname;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'emailVerified')
  bool emailVerified;

  @JsonKey(name: 'uname')
  String uname;

  @JsonKey(name: 'avatar')
  MediaFile? avatar;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'countryCode')
  String? countryCode;

  @JsonKey(name: 'phoneVerified')
  bool? phoneVerified;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'dob')
  String? dob;

  @JsonKey(name: 'about')
  String? about;

  @JsonKey(name: 'profession')
  String? profession;

  @JsonKey(name: 'location')
  String? location;

  @JsonKey(name: 'website')
  String? website;

  @JsonKey(name: 'followersCount')
  int followersCount;

  @JsonKey(name: 'postsCount')
  int postsCount;

  @JsonKey(name: 'followingCount')
  int followingCount;

  @JsonKey(name: 'role')
  String role;

  @JsonKey(name: 'accountPrivacy')
  String accountPrivacy;

  @JsonKey(name: 'accountStatus')
  String accountStatus;

  @JsonKey(name: 'verificationStatus')
  String verificationStatus;

  @JsonKey(name: 'isValid')
  bool isValid;

  @JsonKey(name: 'isVerified')
  bool isVerified;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;
}

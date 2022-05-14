import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/phone.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/user_avatar.dart';

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
    required this.phoneVerified,
    this.gender,
    this.dob,
    this.about,
    this.profession,
    this.location,
    this.website,
    required this.posts,
    required this.followers,
    required this.following,
    required this.role,
    required this.accountType,
    required this.accountStatus,
    required this.isVerified,
    this.token,
    this.expiresAt,
    this.otp,
    this.resetPasswordToken,
    this.resetPasswordExpire,
    this.lastActive,
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
  UserAvatar? avatar;

  @JsonKey(name: 'phone')
  Phone? phone;

  @JsonKey(name: 'phoneVerified')
  bool phoneVerified;

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

  @JsonKey(name: 'posts')
  List<Post> posts;

  @JsonKey(name: 'followers')
  List<dynamic> followers;

  @JsonKey(name: 'following')
  List<dynamic> following;

  @JsonKey(name: 'role')
  String role;

  @JsonKey(name: 'accountType')
  String accountType;

  @JsonKey(name: 'accountStatus')
  String accountStatus;

  @JsonKey(name: 'isVerified')
  bool isVerified;

  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'expiresAt')
  String? expiresAt;

  @JsonKey(name: 'otp')
  String? otp;

  @JsonKey(name: 'resetPasswordToken')
  String? resetPasswordToken;

  @JsonKey(name: 'resetPasswordExpire')
  String? resetPasswordExpire;

  @JsonKey(name: 'lastActive')
  DateTime? lastActive;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;
}

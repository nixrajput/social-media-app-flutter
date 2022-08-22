import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/apis/models/entities/phone.dart';
import 'package:social_media_app/apis/models/entities/post.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile extends Equatable {
  const Profile({
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
    this.loggedInDevices,
    required this.createdAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'fname')
  final String fname;

  @JsonKey(name: 'lname')
  final String lname;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'emailVerified')
  final bool emailVerified;

  @JsonKey(name: 'uname')
  final String uname;

  @JsonKey(name: 'avatar')
  final MediaFile? avatar;

  @JsonKey(name: 'phone')
  final Phone? phone;

  @JsonKey(name: 'phoneVerified')
  final bool phoneVerified;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'dob')
  final String? dob;

  @JsonKey(name: 'about')
  final String? about;

  @JsonKey(name: 'profession')
  final String? profession;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'website')
  final String? website;

  @JsonKey(name: 'posts')
  final List<Post> posts;

  @JsonKey(name: 'followers')
  final List<dynamic> followers;

  @JsonKey(name: 'following')
  final List<dynamic> following;

  @JsonKey(name: 'role')
  final String role;

  @JsonKey(name: 'accountType')
  final String accountType;

  @JsonKey(name: 'accountStatus')
  final String accountStatus;

  @JsonKey(name: 'isVerified')
  final bool isVerified;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'expiresAt')
  final int? expiresAt;

  @JsonKey(name: 'otp')
  final String? otp;

  @JsonKey(name: 'resetPasswordToken')
  final String? resetPasswordToken;

  @JsonKey(name: 'resetPasswordExpire')
  final String? resetPasswordExpire;

  @JsonKey(name: 'lastActive')
  final DateTime? lastActive;

  @JsonKey(name: 'loggedInDevices')
  final List<String>? loggedInDevices;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        fname,
        lname,
        email,
        emailVerified,
        uname,
        avatar,
        phone,
        phoneVerified,
        gender,
        dob,
        about,
        profession,
        location,
        website,
        posts,
        followers,
        following,
        role,
        accountType,
        accountStatus,
        isVerified,
        token,
        expiresAt,
        otp,
        resetPasswordToken,
        resetPasswordExpire,
        lastActive,
        loggedInDevices,
        createdAt,
      ];
}

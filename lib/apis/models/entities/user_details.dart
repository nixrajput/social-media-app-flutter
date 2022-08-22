import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/apis/models/entities/post.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails extends Equatable {
  const UserDetails({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
    this.avatar,
    this.gender,
    this.dob,
    this.about,
    required this.profession,
    required this.posts,
    required this.followers,
    required this.following,
    required this.role,
    required this.accountType,
    required this.accountStatus,
    required this.isVerified,
    required this.createdAt,
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
  final String profession;

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

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        fname,
        lname,
        email,
        uname,
        avatar,
        gender,
        dob,
        about,
        profession,
        posts,
        followers,
        following,
        role,
        accountType,
        accountStatus,
        isVerified,
        createdAt,
      ];
}

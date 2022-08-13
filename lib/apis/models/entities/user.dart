import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user_avatar.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
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
  final UserAvatar? avatar;

  @JsonKey(name: 'accountType')
  final String accountType;

  @JsonKey(name: 'accountStatus')
  final String accountStatus;

  @JsonKey(name: 'isVerified')
  final bool isVerified;

  @override
  List<Object?> get props => <Object?>[
        id,
        fname,
        lname,
        email,
        uname,
        avatar,
        profession,
        accountType,
        accountStatus,
        isVerified,
      ];
}

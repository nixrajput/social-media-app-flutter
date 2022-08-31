// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['_id'] as String,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
      uname: json['uname'] as String,
      avatar: json['avatar'] == null
          ? null
          : MediaFile.fromJson(json['avatar'] as Map<String, dynamic>),
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      phoneVerified: json['phoneVerified'] as bool,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      about: json['about'] as String?,
      profession: json['profession'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      posts: (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      followers: json['followers'] as List<dynamic>,
      following: json['following'] as List<dynamic>,
      followersCount: json['followersCount'] as int,
      followingsCount: json['followingsCount'] as int,
      role: json['role'] as String,
      accountType: json['accountType'] as String,
      accountStatus: json['accountStatus'] as String,
      isVerified: json['isVerified'] as bool,
      token: json['token'] as String?,
      expiresAt: json['expiresAt'] as int?,
      otp: json['otp'] as String?,
      resetPasswordToken: json['resetPasswordToken'] as String?,
      resetPasswordExpire: json['resetPasswordExpire'] as String?,
      lastActive: json['lastActive'] == null
          ? null
          : DateTime.parse(json['lastActive'] as String),
      loggedInDevices: (json['loggedInDevices'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'uname': instance.uname,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'phoneVerified': instance.phoneVerified,
      'gender': instance.gender,
      'dob': instance.dob,
      'about': instance.about,
      'profession': instance.profession,
      'location': instance.location,
      'website': instance.website,
      'posts': instance.posts,
      'followers': instance.followers,
      'following': instance.following,
      'followersCount': instance.followersCount,
      'followingsCount': instance.followingsCount,
      'role': instance.role,
      'accountType': instance.accountType,
      'accountStatus': instance.accountStatus,
      'isVerified': instance.isVerified,
      'token': instance.token,
      'expiresAt': instance.expiresAt,
      'otp': instance.otp,
      'resetPasswordToken': instance.resetPasswordToken,
      'resetPasswordExpire': instance.resetPasswordExpire,
      'lastActive': instance.lastActive?.toIso8601String(),
      'loggedInDevices': instance.loggedInDevices,
      'createdAt': instance.createdAt.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      id: json['_id'] as String,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      uname: json['uname'] as String,
      avatar: json['avatar'] == null
          ? null
          : MediaFile.fromJson(json['avatar'] as Map<String, dynamic>),
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      about: json['about'] as String?,
      website: json['website'] as String?,
      profession: json['profession'] as String?,
      followersCount: json['followersCount'] as int,
      followingCount: json['followingCount'] as int,
      followingStatus: json['followingStatus'] as String,
      postsCount: json['postsCount'] as int,
      accountStatus: json['accountStatus'] as String,
      isPrivate: json['isPrivate'] as bool,
      isValid: json['isValid'] as bool,
      isVerified: json['isVerified'] as bool,
      role: json['role'] as String,
      publicKeys: json['publicKeys'] == null
          ? null
          : ServerKey.fromJson(json['publicKeys'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'uname': instance.uname,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'dob': instance.dob,
      'about': instance.about,
      'profession': instance.profession,
      'website': instance.website,
      'postsCount': instance.postsCount,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'followingStatus': instance.followingStatus,
      'accountStatus': instance.accountStatus,
      'isPrivate': instance.isPrivate,
      'isValid': instance.isValid,
      'isVerified': instance.isVerified,
      'role': instance.role,
      'publicKeys': instance.publicKeys,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

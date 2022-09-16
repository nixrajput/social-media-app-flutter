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
      phone: json['phone'] as String?,
      countryCode: json['countryCode'] as String?,
      phoneVerified: json['phoneVerified'] as bool?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      about: json['about'] as String?,
      profession: json['profession'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      postsCount: json['postsCount'] as int,
      followersCount: json['followersCount'] as int,
      followingCount: json['followingCount'] as int,
      role: json['role'] as String,
      isPrivate: json['isPrivate'] as bool,
      accountStatus: json['accountStatus'] as String,
      verificationStatus: json['verificationStatus'] as String,
      isValid: json['isValid'] as bool,
      isVerified: json['isVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
      'countryCode': instance.countryCode,
      'phoneVerified': instance.phoneVerified,
      'gender': instance.gender,
      'dob': instance.dob,
      'about': instance.about,
      'profession': instance.profession,
      'location': instance.location,
      'website': instance.website,
      'postsCount': instance.postsCount,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'accountStatus': instance.accountStatus,
      'isPrivate': instance.isPrivate,
      'isValid': instance.isValid,
      'isVerified': instance.isVerified,
      'verificationStatus': instance.verificationStatus,
      'role': instance.role,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

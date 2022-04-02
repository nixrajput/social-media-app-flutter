// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      uname: json['uname'] as String,
      avatar: json['avatar'] == null
          ? null
          : UserAvatar.fromJson(json['avatar'] as Map<String, dynamic>),
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      about: json['about'] as String?,
      posts: json['posts'] as List<dynamic>,
      followers: json['followers'] as List<dynamic>,
      following: json['following'] as List<dynamic>,
      role: json['role'] as String,
      accountStatus: json['accountStatus'] as String,
      isVerified: json['isVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'uname': instance.uname,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'gender': instance.gender,
      'dob': instance.dob,
      'about': instance.about,
      'posts': instance.posts,
      'followers': instance.followers,
      'following': instance.following,
      'role': instance.role,
      'accountStatus': instance.accountStatus,
      'createdAt': instance.createdAt.toIso8601String(),
      'isVerified': instance.isVerified,
    };

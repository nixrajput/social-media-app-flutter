// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostOwner _$PostOwnerFromJson(Map<String, dynamic> json) => PostOwner(
      id: json['_id'] as String,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      uname: json['uname'] as String,
      avatar: json['avatar'] == null
          ? null
          : UserAvatar.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostOwnerToJson(PostOwner instance) => <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'uname': instance.uname,
      'avatar': instance.avatar,
    };

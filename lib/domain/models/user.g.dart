// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  isPrivate: json['isPrivate'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'displayName': instance.displayName,
  'avatarUrl': instance.avatarUrl,
  'isPrivate': instance.isPrivate,
  'createdAt': instance.createdAt.toIso8601String(),
};

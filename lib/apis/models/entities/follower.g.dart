// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follower _$FollowerFromJson(Map<String, dynamic> json) => Follower(
      id: json['_id'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FollowerToJson(Follower instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'createdAt': instance.createdAt.toIso8601String(),
    };

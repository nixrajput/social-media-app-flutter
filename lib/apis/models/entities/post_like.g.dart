// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLike _$PostLikeFromJson(Map<String, dynamic> json) => PostLike(
      id: json['_id'] as String?,
      likedBy: json['likedBy'] as String?,
      likedAt: json['likedAt'] == null
          ? null
          : DateTime.parse(json['likedAt'] as String),
    );

Map<String, dynamic> _$PostLikeToJson(PostLike instance) => <String, dynamic>{
      '_id': instance.id,
      'likedBy': instance.likedBy,
      'likedAt': instance.likedAt?.toIso8601String(),
    };

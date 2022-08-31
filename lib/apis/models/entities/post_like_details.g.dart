// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_like_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLikeDetails _$PostLikeDetailsFromJson(Map<String, dynamic> json) =>
    PostLikeDetails(
      id: json['_id'] as String?,
      likedBy: json['likedBy'] == null
          ? null
          : User.fromJson(json['likedBy'] as Map<String, dynamic>),
      likedAt: json['likedAt'] == null
          ? null
          : DateTime.parse(json['likedAt'] as String),
    );

Map<String, dynamic> _$PostLikeDetailsToJson(PostLikeDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'likedBy': instance.likedBy,
      'likedAt': instance.likedAt?.toIso8601String(),
    };

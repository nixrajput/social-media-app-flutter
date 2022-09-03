// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeDetails _$LikeDetailsFromJson(Map<String, dynamic> json) => LikeDetails(
      id: json['_id'] as String?,
      likedBy: json['likedBy'] == null
          ? null
          : User.fromJson(json['likedBy'] as Map<String, dynamic>),
      likedAt: json['likedAt'] == null
          ? null
          : DateTime.parse(json['likedAt'] as String),
    );

Map<String, dynamic> _$LikeDetailsToJson(LikeDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'likedBy': instance.likedBy,
      'likedAt': instance.likedAt?.toIso8601String(),
    };

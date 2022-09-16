// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hashtag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HashTag _$HashTagFromJson(Map<String, dynamic> json) => HashTag(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      postsCount: json['postsCount'] as int?,
    );

Map<String, dynamic> _$HashTagToJson(HashTag instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'postsCount': instance.postsCount,
    };

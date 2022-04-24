// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsResponse _$CommentsResponseFromJson(Map<String, dynamic> json) =>
    CommentsResponse(
      success: json['success'] as bool?,
      count: json['count'] as int?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentsResponseToJson(CommentsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'comments': instance.comments,
    };

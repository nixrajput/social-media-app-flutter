// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowerListResponse _$FollowerListResponseFromJson(
        Map<String, dynamic> json) =>
    FollowerListResponse(
      success: json['success'] as bool?,
      count: json['count'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FollowerListResponseToJson(
        FollowerListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'results': instance.results,
    };

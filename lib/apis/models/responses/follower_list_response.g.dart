// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowerListResponse _$FollowerListResponseFromJson(
        Map<String, dynamic> json) =>
    FollowerListResponse(
      success: json['success'] as bool?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Follower.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..count = json['count'] as int?;

Map<String, dynamic> _$FollowerListResponseToJson(
        FollowerListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'results': instance.results,
    };

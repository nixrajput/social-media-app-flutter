// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) =>
    UserListResponse(
      success: json['success'] as bool?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserListResponseToJson(UserListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'results': instance.results,
    };

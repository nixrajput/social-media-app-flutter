// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) =>
    UserListResponse(
      success: json['success'] as bool?,
      currentPage: json['currentPage'] as int?,
      totalPages: json['totalPages'] as int?,
      limit: json['limit'] as int?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      prevPage: json['prevPage'] as String?,
      hasNextPage: json['hasNextPage'] as bool?,
      nextPage: json['nextPage'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserListResponseToJson(UserListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'limit': instance.limit,
      'hasPrevPage': instance.hasPrevPage,
      'prevPage': instance.prevPage,
      'hasNextPage': instance.hasNextPage,
      'nextPage': instance.nextPage,
      'results': instance.results,
    };

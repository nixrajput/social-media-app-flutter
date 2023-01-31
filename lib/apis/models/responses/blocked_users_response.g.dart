// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_users_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockedUsersResponse _$BlockedUsersResponseFromJson(
        Map<String, dynamic> json) =>
    BlockedUsersResponse(
      success: json['success'] as bool?,
      currentPage: json['currentPage'] as int?,
      totalPages: json['totalPages'] as int?,
      limit: json['limit'] as int?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      prevPage: json['prevPage'] as String?,
      hasNextPage: json['hasNextPage'] as bool?,
      nextPage: json['nextPage'] as String?,
      length: json['length'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlockedUsersResponseToJson(
        BlockedUsersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'limit': instance.limit,
      'hasPrevPage': instance.hasPrevPage,
      'prevPage': instance.prevPage,
      'hasNextPage': instance.hasNextPage,
      'nextPage': instance.nextPage,
      'length': instance.length,
      'results': instance.results,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hashtag_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HashTagResponse _$HashTagResponseFromJson(Map<String, dynamic> json) =>
    HashTagResponse(
      success: json['success'] as bool?,
      currentPage: json['currentPage'] as int?,
      totalPages: json['totalPages'] as int?,
      limit: json['limit'] as int?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      prevPage: json['prevPage'] as String?,
      hasNextPage: json['hasNextPage'] as bool?,
      nextPage: json['nextPage'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => HashTag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HashTagResponseToJson(HashTagResponse instance) =>
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

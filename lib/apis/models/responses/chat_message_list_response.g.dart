// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageListResponse _$ChatMessageListResponseFromJson(
        Map<String, dynamic> json) =>
    ChatMessageListResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      currentPage: json['currentPage'] as int?,
      totalPages: json['totalPages'] as int?,
      limit: json['limit'] as int?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      prevPage: json['prevPage'] as int?,
      hasNextPage: json['hasNextPage'] as bool?,
      nextPage: json['nextPage'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatMessageListResponseToJson(
        ChatMessageListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'limit': instance.limit,
      'hasPrevPage': instance.hasPrevPage,
      'prevPage': instance.prevPage,
      'hasNextPage': instance.hasNextPage,
      'nextPage': instance.nextPage,
      'results': instance.results,
    };

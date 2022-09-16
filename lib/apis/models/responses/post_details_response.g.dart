// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsResponse _$PostDetailsResponseFromJson(Map<String, dynamic> json) =>
    PostDetailsResponse(
      success: json['success'] as bool?,
      post: json['post'] == null
          ? null
          : Post.fromJson(json['post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostDetailsResponseToJson(
        PostDetailsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'post': instance.post,
    };

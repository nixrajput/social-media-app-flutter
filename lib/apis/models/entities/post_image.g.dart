// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostImage _$PostImageFromJson(Map<String, dynamic> json) => PostImage(
      id: json['_id'] as String?,
      publicId: json['public_id'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$PostImageToJson(PostImage instance) => <String, dynamic>{
      '_id': instance.id,
      'public_id': instance.publicId,
      'url': instance.url,
    };

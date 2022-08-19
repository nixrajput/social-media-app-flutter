// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_media_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostMediaFile _$PostMediaFileFromJson(Map<String, dynamic> json) =>
    PostMediaFile(
      id: json['_id'] as String?,
      link: json['link'] == null
          ? null
          : MediaFile.fromJson(json['link'] as Map<String, dynamic>),
      mediaType: json['mediaType'] as String?,
    );

Map<String, dynamic> _$PostMediaFileToJson(PostMediaFile instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'link': instance.link,
      'mediaType': instance.mediaType,
    };

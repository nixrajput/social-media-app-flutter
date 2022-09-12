// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_media_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostMediaFile _$PostMediaFileFromJson(Map<String, dynamic> json) =>
    PostMediaFile(
      id: json['_id'] as String?,
      publicId: json['public_id'] as String?,
      url: json['url'] as String?,
      mediaType: json['mediaType'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : MediaFile.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostMediaFileToJson(PostMediaFile instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'public_id': instance.publicId,
      'url': instance.url,
      'mediaType': instance.mediaType,
      'thumbnail': instance.thumbnail,
    };

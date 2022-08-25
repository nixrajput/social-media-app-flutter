// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetails _$PostDetailsFromJson(Map<String, dynamic> json) => PostDetails(
      id: json['_id'] as String,
      caption: json['caption'] as String?,
      mediaFiles: (json['mediaFiles'] as List<dynamic>?)
          ?.map((e) => PostMediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
      likes: json['likes'] as List<dynamic>,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      postStatus: json['postStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PostDetailsToJson(PostDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'caption': instance.caption,
      'mediaFiles': instance.mediaFiles,
      'owner': instance.owner,
      'likes': instance.likes,
      'comments': instance.comments,
      'postStatus': instance.postStatus,
      'createdAt': instance.createdAt.toIso8601String(),
    };

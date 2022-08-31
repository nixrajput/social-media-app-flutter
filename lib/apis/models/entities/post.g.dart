// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['_id'] as String?,
      caption: json['caption'] as String?,
      mediaFiles: (json['mediaFiles'] as List<dynamic>?)
          ?.map((e) => PostMediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
      likes: (json['likes'] as List<dynamic>)
          .map((e) => PostLike.fromJson(e as Map<String, dynamic>))
          .toList(),
      likesCount: json['likesCount'] as int,
      comments:
          (json['comments'] as List<dynamic>).map((e) => e as String).toList(),
      commentsCount: json['commentsCount'] as int,
      postStatus: json['postStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      '_id': instance.id,
      'caption': instance.caption,
      'mediaFiles': instance.mediaFiles,
      'owner': instance.owner,
      'likes': instance.likes,
      'likesCount': instance.likesCount,
      'comments': instance.comments,
      'commentsCount': instance.commentsCount,
      'postStatus': instance.postStatus,
      'createdAt': instance.createdAt.toIso8601String(),
    };

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
      hashtags:
          (json['hashtags'] as List<dynamic>).map((e) => e as String).toList(),
      userMentions: (json['userMentions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      postType: json['postType'] as String,
      likesCount: json['likesCount'] as int,
      commentsCount: json['commentsCount'] as int,
      isLiked: json['isLiked'] as bool,
      isArchived: json['isArchived'] as bool,
      visibility: json['visibility'] as String,
      allowComments: json['allowComments'] as bool,
      allowLikes: json['allowLikes'] as bool,
      allowReposts: json['allowReposts'] as bool,
      allowShare: json['allowShare'] as bool,
      allowSave: json['allowSave'] as bool,
      allowDownload: json['allowDownload'] as bool,
      postStatus: json['postStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      '_id': instance.id,
      'caption': instance.caption,
      'mediaFiles': instance.mediaFiles,
      'owner': instance.owner,
      'hashtags': instance.hashtags,
      'userMentions': instance.userMentions,
      'postType': instance.postType,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'isLiked': instance.isLiked,
      'isArchived': instance.isArchived,
      'visibility': instance.visibility,
      'allowComments': instance.allowComments,
      'allowLikes': instance.allowLikes,
      'allowReposts': instance.allowReposts,
      'allowShare': instance.allowShare,
      'allowSave': instance.allowSave,
      'allowDownload': instance.allowDownload,
      'postStatus': instance.postStatus,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

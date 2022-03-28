// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPost _$UserPostFromJson(Map<String, dynamic> json) => UserPost(
      id: json['_id'] as String,
      caption: json['caption'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: json['owner'] as String,
      likes: json['likes'] as List<dynamic>,
      comments: json['comments'] as List<dynamic>,
      postStatus: json['postStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserPostToJson(UserPost instance) => <String, dynamic>{
      '_id': instance.id,
      'caption': instance.caption,
      'images': instance.images,
      'owner': instance.owner,
      'likes': instance.likes,
      'comments': instance.comments,
      'postStatus': instance.postStatus,
      'createdAt': instance.createdAt.toIso8601String(),
    };

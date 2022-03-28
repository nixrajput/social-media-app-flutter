// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['_id'] as String,
      caption: json['caption'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: PostOwner.fromJson(json['owner'] as Map<String, dynamic>),
      likes: json['likes'] as List<dynamic>,
      comments: json['comments'] as List<dynamic>,
      postStatus: json['postStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      '_id': instance.id,
      'caption': instance.caption,
      'images': instance.images,
      'owner': instance.owner,
      'likes': instance.likes,
      'comments': instance.comments,
      'postStatus': instance.postStatus,
      'createdAt': instance.createdAt.toIso8601String(),
    };

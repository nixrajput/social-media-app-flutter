// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['_id'] as String,
      comment: json['comment'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      post: json['post'] as String,
      likesCount: json['likesCount'] as int,
      commentStatus: json['commentStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      '_id': instance.id,
      'comment': instance.comment,
      'post': instance.post,
      'user': instance.user,
      'likesCount': instance.likesCount,
      'commentStatus': instance.commentStatus,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

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
      likes: json['likes'] as List<dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      '_id': instance.id,
      'comment': instance.comment,
      'user': instance.user,
      'post': instance.post,
      'likes': instance.likes,
      'createdAt': instance.createdAt.toIso8601String(),
    };

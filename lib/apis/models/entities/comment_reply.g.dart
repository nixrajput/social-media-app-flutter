// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_reply.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommentReplyCWProxy {
  CommentReply id(String? id);

  CommentReply reply(String? reply);

  CommentReply comment(String? comment);

  CommentReply user(User? user);

  CommentReply post(String? post);

  CommentReply likesCount(int? likesCount);

  CommentReply isLiked(bool? isLiked);

  CommentReply allowLikes(bool? allowLikes);

  CommentReply visibility(String? visibility);

  CommentReply status(String? status);

  CommentReply createdAt(DateTime? createdAt);

  CommentReply updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommentReply(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommentReply(...).copyWith(id: 12, name: "My name")
  /// ````
  CommentReply call({
    String? id,
    String? reply,
    String? comment,
    User? user,
    String? post,
    int? likesCount,
    bool? isLiked,
    bool? allowLikes,
    String? visibility,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCommentReply.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCommentReply.copyWith.fieldName(...)`
class _$CommentReplyCWProxyImpl implements _$CommentReplyCWProxy {
  const _$CommentReplyCWProxyImpl(this._value);

  final CommentReply _value;

  @override
  CommentReply id(String? id) => this(id: id);

  @override
  CommentReply reply(String? reply) => this(reply: reply);

  @override
  CommentReply comment(String? comment) => this(comment: comment);

  @override
  CommentReply user(User? user) => this(user: user);

  @override
  CommentReply post(String? post) => this(post: post);

  @override
  CommentReply likesCount(int? likesCount) => this(likesCount: likesCount);

  @override
  CommentReply isLiked(bool? isLiked) => this(isLiked: isLiked);

  @override
  CommentReply allowLikes(bool? allowLikes) => this(allowLikes: allowLikes);

  @override
  CommentReply visibility(String? visibility) => this(visibility: visibility);

  @override
  CommentReply status(String? status) => this(status: status);

  @override
  CommentReply createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  CommentReply updatedAt(DateTime? updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommentReply(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommentReply(...).copyWith(id: 12, name: "My name")
  /// ````
  CommentReply call({
    Object? id = const $CopyWithPlaceholder(),
    Object? reply = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? post = const $CopyWithPlaceholder(),
    Object? likesCount = const $CopyWithPlaceholder(),
    Object? isLiked = const $CopyWithPlaceholder(),
    Object? allowLikes = const $CopyWithPlaceholder(),
    Object? visibility = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return CommentReply(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      reply: reply == const $CopyWithPlaceholder()
          ? _value.reply
          // ignore: cast_nullable_to_non_nullable
          : reply as String?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User?,
      post: post == const $CopyWithPlaceholder()
          ? _value.post
          // ignore: cast_nullable_to_non_nullable
          : post as String?,
      likesCount: likesCount == const $CopyWithPlaceholder()
          ? _value.likesCount
          // ignore: cast_nullable_to_non_nullable
          : likesCount as int?,
      isLiked: isLiked == const $CopyWithPlaceholder()
          ? _value.isLiked
          // ignore: cast_nullable_to_non_nullable
          : isLiked as bool?,
      allowLikes: allowLikes == const $CopyWithPlaceholder()
          ? _value.allowLikes
          // ignore: cast_nullable_to_non_nullable
          : allowLikes as bool?,
      visibility: visibility == const $CopyWithPlaceholder()
          ? _value.visibility
          // ignore: cast_nullable_to_non_nullable
          : visibility as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $CommentReplyCopyWith on CommentReply {
  /// Returns a callable class that can be used as follows: `instanceOfCommentReply.copyWith(...)` or like so:`instanceOfCommentReply.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommentReplyCWProxy get copyWith => _$CommentReplyCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentReplyAdapter extends TypeAdapter<CommentReply> {
  @override
  final int typeId = 15;

  @override
  CommentReply read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentReply(
      id: fields[0] as String?,
      reply: fields[1] as String?,
      comment: fields[2] as String?,
      user: fields[4] as User?,
      post: fields[3] as String?,
      likesCount: fields[5] as int?,
      isLiked: fields[6] as bool?,
      allowLikes: fields[7] as bool?,
      visibility: fields[8] as String?,
      status: fields[9] as String?,
      createdAt: fields[10] as DateTime?,
      updatedAt: fields[11] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, CommentReply obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.reply)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.post)
      ..writeByte(4)
      ..write(obj.user)
      ..writeByte(5)
      ..write(obj.likesCount)
      ..writeByte(6)
      ..write(obj.isLiked)
      ..writeByte(7)
      ..write(obj.allowLikes)
      ..writeByte(8)
      ..write(obj.visibility)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentReplyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentReply _$CommentReplyFromJson(Map<String, dynamic> json) => CommentReply(
      id: json['_id'] as String?,
      reply: json['reply'] as String?,
      comment: json['comment'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      post: json['post'] as String?,
      likesCount: json['likesCount'] as int?,
      isLiked: json['isLiked'] as bool?,
      allowLikes: json['allowLikes'] as bool?,
      visibility: json['visibility'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CommentReplyToJson(CommentReply instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'reply': instance.reply,
      'comment': instance.comment,
      'post': instance.post,
      'user': instance.user,
      'likesCount': instance.likesCount,
      'isLiked': instance.isLiked,
      'allowLikes': instance.allowLikes,
      'visibility': instance.visibility,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommentCWProxy {
  Comment id(String id);

  Comment comment(String comment);

  Comment user(User user);

  Comment post(String post);

  Comment likesCount(int likesCount);

  Comment commentStatus(String commentStatus);

  Comment createdAt(DateTime createdAt);

  Comment updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Comment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Comment(...).copyWith(id: 12, name: "My name")
  /// ````
  Comment call({
    String? id,
    String? comment,
    User? user,
    String? post,
    int? likesCount,
    String? commentStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComment.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfComment.copyWith.fieldName(...)`
class _$CommentCWProxyImpl implements _$CommentCWProxy {
  const _$CommentCWProxyImpl(this._value);

  final Comment _value;

  @override
  Comment id(String id) => this(id: id);

  @override
  Comment comment(String comment) => this(comment: comment);

  @override
  Comment user(User user) => this(user: user);

  @override
  Comment post(String post) => this(post: post);

  @override
  Comment likesCount(int likesCount) => this(likesCount: likesCount);

  @override
  Comment commentStatus(String commentStatus) =>
      this(commentStatus: commentStatus);

  @override
  Comment createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Comment updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Comment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Comment(...).copyWith(id: 12, name: "My name")
  /// ````
  Comment call({
    Object? id = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? post = const $CopyWithPlaceholder(),
    Object? likesCount = const $CopyWithPlaceholder(),
    Object? commentStatus = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Comment(
      id: id == const $CopyWithPlaceholder() || id == null
          // ignore: unnecessary_non_null_assertion
          ? _value.id!
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      comment: comment == const $CopyWithPlaceholder() || comment == null
          // ignore: unnecessary_non_null_assertion
          ? _value.comment!
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
      user: user == const $CopyWithPlaceholder() || user == null
          // ignore: unnecessary_non_null_assertion
          ? _value.user!
          // ignore: cast_nullable_to_non_nullable
          : user as User,
      post: post == const $CopyWithPlaceholder() || post == null
          // ignore: unnecessary_non_null_assertion
          ? _value.post!
          // ignore: cast_nullable_to_non_nullable
          : post as String,
      likesCount:
          likesCount == const $CopyWithPlaceholder() || likesCount == null
              // ignore: unnecessary_non_null_assertion
              ? _value.likesCount!
              // ignore: cast_nullable_to_non_nullable
              : likesCount as int,
      commentStatus:
          commentStatus == const $CopyWithPlaceholder() || commentStatus == null
              // ignore: unnecessary_non_null_assertion
              ? _value.commentStatus!
              // ignore: cast_nullable_to_non_nullable
              : commentStatus as String,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          // ignore: unnecessary_non_null_assertion
          ? _value.createdAt!
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          // ignore: unnecessary_non_null_assertion
          ? _value.updatedAt!
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $CommentCopyWith on Comment {
  /// Returns a callable class that can be used as follows: `instanceOfComment.copyWith(...)` or like so:`instanceOfComment.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommentCWProxy get copyWith => _$CommentCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final int typeId = 15;

  @override
  Comment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comment(
      id: fields[0] as String,
      comment: fields[1] as String,
      user: fields[3] as User,
      post: fields[2] as String,
      likesCount: fields[4] as int,
      commentStatus: fields[5] as String,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.post)
      ..writeByte(3)
      ..write(obj.user)
      ..writeByte(4)
      ..write(obj.likesCount)
      ..writeByte(5)
      ..write(obj.commentStatus)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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

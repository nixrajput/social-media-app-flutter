// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PostCWProxy {
  Post allowComments(bool allowComments);

  Post allowDownload(bool allowDownload);

  Post allowLikes(bool allowLikes);

  Post allowReposts(bool allowReposts);

  Post allowSave(bool allowSave);

  Post allowShare(bool allowShare);

  Post caption(String? caption);

  Post commentsCount(int commentsCount);

  Post createdAt(DateTime createdAt);

  Post hashtags(List<String> hashtags);

  Post id(String? id);

  Post isArchived(bool isArchived);

  Post isLiked(bool isLiked);

  Post likesCount(int likesCount);

  Post mediaFiles(List<PostMediaFile>? mediaFiles);

  Post owner(User owner);

  Post postStatus(String postStatus);

  Post postType(String postType);

  Post updatedAt(DateTime updatedAt);

  Post userMentions(List<String> userMentions);

  Post visibility(String visibility);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Post(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Post(...).copyWith(id: 12, name: "My name")
  /// ````
  Post call({
    bool? allowComments,
    bool? allowDownload,
    bool? allowLikes,
    bool? allowReposts,
    bool? allowSave,
    bool? allowShare,
    String? caption,
    int? commentsCount,
    DateTime? createdAt,
    List<String>? hashtags,
    String? id,
    bool? isArchived,
    bool? isLiked,
    int? likesCount,
    List<PostMediaFile>? mediaFiles,
    User? owner,
    String? postStatus,
    String? postType,
    DateTime? updatedAt,
    List<String>? userMentions,
    String? visibility,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPost.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPost.copyWith.fieldName(...)`
class _$PostCWProxyImpl implements _$PostCWProxy {
  final Post _value;

  const _$PostCWProxyImpl(this._value);

  @override
  Post allowComments(bool allowComments) => this(allowComments: allowComments);

  @override
  Post allowDownload(bool allowDownload) => this(allowDownload: allowDownload);

  @override
  Post allowLikes(bool allowLikes) => this(allowLikes: allowLikes);

  @override
  Post allowReposts(bool allowReposts) => this(allowReposts: allowReposts);

  @override
  Post allowSave(bool allowSave) => this(allowSave: allowSave);

  @override
  Post allowShare(bool allowShare) => this(allowShare: allowShare);

  @override
  Post caption(String? caption) => this(caption: caption);

  @override
  Post commentsCount(int commentsCount) => this(commentsCount: commentsCount);

  @override
  Post createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Post hashtags(List<String> hashtags) => this(hashtags: hashtags);

  @override
  Post id(String? id) => this(id: id);

  @override
  Post isArchived(bool isArchived) => this(isArchived: isArchived);

  @override
  Post isLiked(bool isLiked) => this(isLiked: isLiked);

  @override
  Post likesCount(int likesCount) => this(likesCount: likesCount);

  @override
  Post mediaFiles(List<PostMediaFile>? mediaFiles) =>
      this(mediaFiles: mediaFiles);

  @override
  Post owner(User owner) => this(owner: owner);

  @override
  Post postStatus(String postStatus) => this(postStatus: postStatus);

  @override
  Post postType(String postType) => this(postType: postType);

  @override
  Post updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  Post userMentions(List<String> userMentions) =>
      this(userMentions: userMentions);

  @override
  Post visibility(String visibility) => this(visibility: visibility);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Post(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Post(...).copyWith(id: 12, name: "My name")
  /// ````
  Post call({
    Object? allowComments = const $CopyWithPlaceholder(),
    Object? allowDownload = const $CopyWithPlaceholder(),
    Object? allowLikes = const $CopyWithPlaceholder(),
    Object? allowReposts = const $CopyWithPlaceholder(),
    Object? allowSave = const $CopyWithPlaceholder(),
    Object? allowShare = const $CopyWithPlaceholder(),
    Object? caption = const $CopyWithPlaceholder(),
    Object? commentsCount = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? hashtags = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isArchived = const $CopyWithPlaceholder(),
    Object? isLiked = const $CopyWithPlaceholder(),
    Object? likesCount = const $CopyWithPlaceholder(),
    Object? mediaFiles = const $CopyWithPlaceholder(),
    Object? owner = const $CopyWithPlaceholder(),
    Object? postStatus = const $CopyWithPlaceholder(),
    Object? postType = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? userMentions = const $CopyWithPlaceholder(),
    Object? visibility = const $CopyWithPlaceholder(),
  }) {
    return Post(
      allowComments:
          allowComments == const $CopyWithPlaceholder() || allowComments == null
              ? _value.allowComments
              // ignore: cast_nullable_to_non_nullable
              : allowComments as bool,
      allowDownload:
          allowDownload == const $CopyWithPlaceholder() || allowDownload == null
              ? _value.allowDownload
              // ignore: cast_nullable_to_non_nullable
              : allowDownload as bool,
      allowLikes:
          allowLikes == const $CopyWithPlaceholder() || allowLikes == null
              ? _value.allowLikes
              // ignore: cast_nullable_to_non_nullable
              : allowLikes as bool,
      allowReposts:
          allowReposts == const $CopyWithPlaceholder() || allowReposts == null
              ? _value.allowReposts
              // ignore: cast_nullable_to_non_nullable
              : allowReposts as bool,
      allowSave: allowSave == const $CopyWithPlaceholder() || allowSave == null
          ? _value.allowSave
          // ignore: cast_nullable_to_non_nullable
          : allowSave as bool,
      allowShare:
          allowShare == const $CopyWithPlaceholder() || allowShare == null
              ? _value.allowShare
              // ignore: cast_nullable_to_non_nullable
              : allowShare as bool,
      caption: caption == const $CopyWithPlaceholder()
          ? _value.caption
          // ignore: cast_nullable_to_non_nullable
          : caption as String?,
      commentsCount:
          commentsCount == const $CopyWithPlaceholder() || commentsCount == null
              ? _value.commentsCount
              // ignore: cast_nullable_to_non_nullable
              : commentsCount as int,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      hashtags: hashtags == const $CopyWithPlaceholder() || hashtags == null
          ? _value.hashtags
          // ignore: cast_nullable_to_non_nullable
          : hashtags as List<String>,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      isArchived:
          isArchived == const $CopyWithPlaceholder() || isArchived == null
              ? _value.isArchived
              // ignore: cast_nullable_to_non_nullable
              : isArchived as bool,
      isLiked: isLiked == const $CopyWithPlaceholder() || isLiked == null
          ? _value.isLiked
          // ignore: cast_nullable_to_non_nullable
          : isLiked as bool,
      likesCount:
          likesCount == const $CopyWithPlaceholder() || likesCount == null
              ? _value.likesCount
              // ignore: cast_nullable_to_non_nullable
              : likesCount as int,
      mediaFiles: mediaFiles == const $CopyWithPlaceholder()
          ? _value.mediaFiles
          // ignore: cast_nullable_to_non_nullable
          : mediaFiles as List<PostMediaFile>?,
      owner: owner == const $CopyWithPlaceholder() || owner == null
          ? _value.owner
          // ignore: cast_nullable_to_non_nullable
          : owner as User,
      postStatus:
          postStatus == const $CopyWithPlaceholder() || postStatus == null
              ? _value.postStatus
              // ignore: cast_nullable_to_non_nullable
              : postStatus as String,
      postType: postType == const $CopyWithPlaceholder() || postType == null
          ? _value.postType
          // ignore: cast_nullable_to_non_nullable
          : postType as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      userMentions:
          userMentions == const $CopyWithPlaceholder() || userMentions == null
              ? _value.userMentions
              // ignore: cast_nullable_to_non_nullable
              : userMentions as List<String>,
      visibility:
          visibility == const $CopyWithPlaceholder() || visibility == null
              ? _value.visibility
              // ignore: cast_nullable_to_non_nullable
              : visibility as String,
    );
  }
}

extension $PostCopyWith on Post {
  /// Returns a callable class that can be used as follows: `instanceOfPost.copyWith(...)` or like so:`instanceOfPost.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PostCWProxy get copyWith => _$PostCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 1;

  @override
  Post read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Post(
      id: fields[0] as String?,
      caption: fields[1] as String?,
      mediaFiles: (fields[2] as List?)?.cast<PostMediaFile>(),
      owner: fields[3] as User,
      hashtags: (fields[4] as List).cast<String>(),
      userMentions: (fields[5] as List).cast<String>(),
      postType: fields[6] as String,
      likesCount: fields[7] as int,
      commentsCount: fields[8] as int,
      isLiked: fields[9] as bool,
      isArchived: fields[10] as bool,
      visibility: fields[11] as String,
      allowComments: fields[12] as bool,
      allowLikes: fields[13] as bool,
      allowReposts: fields[14] as bool,
      allowShare: fields[15] as bool,
      allowSave: fields[16] as bool,
      allowDownload: fields[17] as bool,
      postStatus: fields[18] as String,
      createdAt: fields[19] as DateTime,
      updatedAt: fields[20] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.caption)
      ..writeByte(2)
      ..write(obj.mediaFiles)
      ..writeByte(3)
      ..write(obj.owner)
      ..writeByte(4)
      ..write(obj.hashtags)
      ..writeByte(5)
      ..write(obj.userMentions)
      ..writeByte(6)
      ..write(obj.postType)
      ..writeByte(7)
      ..write(obj.likesCount)
      ..writeByte(8)
      ..write(obj.commentsCount)
      ..writeByte(9)
      ..write(obj.isLiked)
      ..writeByte(10)
      ..write(obj.isArchived)
      ..writeByte(11)
      ..write(obj.visibility)
      ..writeByte(12)
      ..write(obj.allowComments)
      ..writeByte(13)
      ..write(obj.allowLikes)
      ..writeByte(14)
      ..write(obj.allowReposts)
      ..writeByte(15)
      ..write(obj.allowShare)
      ..writeByte(16)
      ..write(obj.allowSave)
      ..writeByte(17)
      ..write(obj.allowDownload)
      ..writeByte(18)
      ..write(obj.postStatus)
      ..writeByte(19)
      ..write(obj.createdAt)
      ..writeByte(20)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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

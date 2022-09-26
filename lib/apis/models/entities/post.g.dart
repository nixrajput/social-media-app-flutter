// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

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

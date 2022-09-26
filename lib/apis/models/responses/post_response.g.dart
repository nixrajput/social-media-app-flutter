// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostResponseAdapter extends TypeAdapter<PostResponse> {
  @override
  final int typeId = 4;

  @override
  PostResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostResponse(
      success: fields[0] as bool?,
      currentPage: fields[1] as int?,
      totalPages: fields[2] as int?,
      limit: fields[3] as int?,
      hasPrevPage: fields[4] as bool?,
      prevPage: fields[5] as String?,
      hasNextPage: fields[6] as bool?,
      nextPage: fields[7] as String?,
      results: (fields[8] as List?)?.cast<Post>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostResponse obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.currentPage)
      ..writeByte(2)
      ..write(obj.totalPages)
      ..writeByte(3)
      ..write(obj.limit)
      ..writeByte(4)
      ..write(obj.hasPrevPage)
      ..writeByte(5)
      ..write(obj.prevPage)
      ..writeByte(6)
      ..write(obj.hasNextPage)
      ..writeByte(7)
      ..write(obj.nextPage)
      ..writeByte(8)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      success: json['success'] as bool?,
      currentPage: json['currentPage'] as int?,
      totalPages: json['totalPages'] as int?,
      limit: json['limit'] as int?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      prevPage: json['prevPage'] as String?,
      hasNextPage: json['hasNextPage'] as bool?,
      nextPage: json['nextPage'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'limit': instance.limit,
      'hasPrevPage': instance.hasPrevPage,
      'prevPage': instance.prevPage,
      'hasNextPage': instance.hasNextPage,
      'nextPage': instance.nextPage,
      'results': instance.results,
    };

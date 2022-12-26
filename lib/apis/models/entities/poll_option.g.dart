// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_option.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PollOptionCWProxy {
  PollOption id(String? id);

  PollOption post(String? post);

  PollOption option(String? option);

  PollOption votes(int? votes);

  PollOption createdAt(DateTime? createdAt);

  PollOption updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PollOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PollOption(...).copyWith(id: 12, name: "My name")
  /// ````
  PollOption call({
    String? id,
    String? post,
    String? option,
    int? votes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPollOption.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPollOption.copyWith.fieldName(...)`
class _$PollOptionCWProxyImpl implements _$PollOptionCWProxy {
  const _$PollOptionCWProxyImpl(this._value);

  final PollOption _value;

  @override
  PollOption id(String? id) => this(id: id);

  @override
  PollOption post(String? post) => this(post: post);

  @override
  PollOption option(String? option) => this(option: option);

  @override
  PollOption votes(int? votes) => this(votes: votes);

  @override
  PollOption createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  PollOption updatedAt(DateTime? updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PollOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PollOption(...).copyWith(id: 12, name: "My name")
  /// ````
  PollOption call({
    Object? id = const $CopyWithPlaceholder(),
    Object? post = const $CopyWithPlaceholder(),
    Object? option = const $CopyWithPlaceholder(),
    Object? votes = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return PollOption(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      post: post == const $CopyWithPlaceholder()
          ? _value.post
          // ignore: cast_nullable_to_non_nullable
          : post as String?,
      option: option == const $CopyWithPlaceholder()
          ? _value.option
          // ignore: cast_nullable_to_non_nullable
          : option as String?,
      votes: votes == const $CopyWithPlaceholder()
          ? _value.votes
          // ignore: cast_nullable_to_non_nullable
          : votes as int?,
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

extension $PollOptionCopyWith on PollOption {
  /// Returns a callable class that can be used as follows: `instanceOfPollOption.copyWith(...)` or like so:`instanceOfPollOption.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PollOptionCWProxy get copyWith => _$PollOptionCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PollOptionAdapter extends TypeAdapter<PollOption> {
  @override
  final int typeId = 16;

  @override
  PollOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PollOption(
      id: fields[0] as String?,
      post: fields[1] as String?,
      option: fields[2] as String?,
      votes: fields[3] as int?,
      createdAt: fields[4] as DateTime?,
      updatedAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PollOption obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.post)
      ..writeByte(2)
      ..write(obj.option)
      ..writeByte(3)
      ..write(obj.votes)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PollOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollOption _$PollOptionFromJson(Map<String, dynamic> json) => PollOption(
      id: json['_id'] as String?,
      post: json['post'] as String?,
      option: json['option'] as String?,
      votes: json['votes'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PollOptionToJson(PollOption instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'post': instance.post,
      'option': instance.option,
      'votes': instance.votes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FollowerCWProxy {
  Follower createdAt(DateTime createdAt);

  Follower id(String id);

  Follower updatedAt(DateTime updatedAt);

  Follower user(User user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Follower(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Follower(...).copyWith(id: 12, name: "My name")
  /// ````
  Follower call({
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
    User? user,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFollower.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFollower.copyWith.fieldName(...)`
class _$FollowerCWProxyImpl implements _$FollowerCWProxy {
  final Follower _value;

  const _$FollowerCWProxyImpl(this._value);

  @override
  Follower createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Follower id(String id) => this(id: id);

  @override
  Follower updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  Follower user(User user) => this(user: user);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Follower(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Follower(...).copyWith(id: 12, name: "My name")
  /// ````
  Follower call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return Follower(
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      user: user == const $CopyWithPlaceholder() || user == null
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $FollowerCopyWith on Follower {
  /// Returns a callable class that can be used as follows: `instanceOfFollower.copyWith(...)` or like so:`instanceOfFollower.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FollowerCWProxy get copyWith => _$FollowerCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowerAdapter extends TypeAdapter<Follower> {
  @override
  final int typeId = 14;

  @override
  Follower read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Follower(
      id: fields[0] as String,
      user: fields[1] as User,
      createdAt: fields[2] as DateTime,
      updatedAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Follower obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follower _$FollowerFromJson(Map<String, dynamic> json) => Follower(
      id: json['_id'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FollowerToJson(Follower instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

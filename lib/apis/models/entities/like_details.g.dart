// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_details.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LikeDetailsCWProxy {
  LikeDetails id(String? id);

  LikeDetails likedAt(DateTime? likedAt);

  LikeDetails likedBy(User? likedBy);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LikeDetails(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LikeDetails(...).copyWith(id: 12, name: "My name")
  /// ````
  LikeDetails call({
    String? id,
    DateTime? likedAt,
    User? likedBy,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLikeDetails.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLikeDetails.copyWith.fieldName(...)`
class _$LikeDetailsCWProxyImpl implements _$LikeDetailsCWProxy {
  final LikeDetails _value;

  const _$LikeDetailsCWProxyImpl(this._value);

  @override
  LikeDetails id(String? id) => this(id: id);

  @override
  LikeDetails likedAt(DateTime? likedAt) => this(likedAt: likedAt);

  @override
  LikeDetails likedBy(User? likedBy) => this(likedBy: likedBy);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LikeDetails(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LikeDetails(...).copyWith(id: 12, name: "My name")
  /// ````
  LikeDetails call({
    Object? id = const $CopyWithPlaceholder(),
    Object? likedAt = const $CopyWithPlaceholder(),
    Object? likedBy = const $CopyWithPlaceholder(),
  }) {
    return LikeDetails(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      likedAt: likedAt == const $CopyWithPlaceholder()
          ? _value.likedAt
          // ignore: cast_nullable_to_non_nullable
          : likedAt as DateTime?,
      likedBy: likedBy == const $CopyWithPlaceholder()
          ? _value.likedBy
          // ignore: cast_nullable_to_non_nullable
          : likedBy as User?,
    );
  }
}

extension $LikeDetailsCopyWith on LikeDetails {
  /// Returns a callable class that can be used as follows: `instanceOfLikeDetails.copyWith(...)` or like so:`instanceOfLikeDetails.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LikeDetailsCWProxy get copyWith => _$LikeDetailsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeDetails _$LikeDetailsFromJson(Map<String, dynamic> json) => LikeDetails(
      id: json['_id'] as String?,
      likedBy: json['likedBy'] == null
          ? null
          : User.fromJson(json['likedBy'] as Map<String, dynamic>),
      likedAt: json['likedAt'] == null
          ? null
          : DateTime.parse(json['likedAt'] as String),
    );

Map<String, dynamic> _$LikeDetailsToJson(LikeDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'likedBy': instance.likedBy,
      'likedAt': instance.likedAt?.toIso8601String(),
    };

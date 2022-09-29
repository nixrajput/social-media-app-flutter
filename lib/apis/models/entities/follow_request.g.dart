// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FollowRequestCWProxy {
  FollowRequest createdAt(DateTime createdAt);

  FollowRequest from(User from);

  FollowRequest id(String id);

  FollowRequest to(User to);

  FollowRequest updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FollowRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FollowRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  FollowRequest call({
    DateTime? createdAt,
    User? from,
    String? id,
    User? to,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFollowRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFollowRequest.copyWith.fieldName(...)`
class _$FollowRequestCWProxyImpl implements _$FollowRequestCWProxy {
  final FollowRequest _value;

  const _$FollowRequestCWProxyImpl(this._value);

  @override
  FollowRequest createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  FollowRequest from(User from) => this(from: from);

  @override
  FollowRequest id(String id) => this(id: id);

  @override
  FollowRequest to(User to) => this(to: to);

  @override
  FollowRequest updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FollowRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FollowRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  FollowRequest call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return FollowRequest(
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      from: from == const $CopyWithPlaceholder() || from == null
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as User,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      to: to == const $CopyWithPlaceholder() || to == null
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as User,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $FollowRequestCopyWith on FollowRequest {
  /// Returns a callable class that can be used as follows: `instanceOfFollowRequest.copyWith(...)` or like so:`instanceOfFollowRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FollowRequestCWProxy get copyWith => _$FollowRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowRequest _$FollowRequestFromJson(Map<String, dynamic> json) =>
    FollowRequest(
      id: json['_id'] as String,
      to: User.fromJson(json['to'] as Map<String, dynamic>),
      from: User.fromJson(json['from'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FollowRequestToJson(FollowRequest instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'to': instance.to,
      'from': instance.from,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

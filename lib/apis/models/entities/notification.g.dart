// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ApiNotificationCWProxy {
  ApiNotification body(String body);

  ApiNotification createdAt(DateTime createdAt);

  ApiNotification from(User from);

  ApiNotification id(String id);

  ApiNotification isRead(bool isRead);

  ApiNotification refId(String? refId);

  ApiNotification to(User to);

  ApiNotification type(String type);

  ApiNotification updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ApiNotification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ApiNotification(...).copyWith(id: 12, name: "My name")
  /// ````
  ApiNotification call({
    String? body,
    DateTime? createdAt,
    User? from,
    String? id,
    bool? isRead,
    String? refId,
    User? to,
    String? type,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfApiNotification.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfApiNotification.copyWith.fieldName(...)`
class _$ApiNotificationCWProxyImpl implements _$ApiNotificationCWProxy {
  final ApiNotification _value;

  const _$ApiNotificationCWProxyImpl(this._value);

  @override
  ApiNotification body(String body) => this(body: body);

  @override
  ApiNotification createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  ApiNotification from(User from) => this(from: from);

  @override
  ApiNotification id(String id) => this(id: id);

  @override
  ApiNotification isRead(bool isRead) => this(isRead: isRead);

  @override
  ApiNotification refId(String? refId) => this(refId: refId);

  @override
  ApiNotification to(User to) => this(to: to);

  @override
  ApiNotification type(String type) => this(type: type);

  @override
  ApiNotification updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ApiNotification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ApiNotification(...).copyWith(id: 12, name: "My name")
  /// ````
  ApiNotification call({
    Object? body = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isRead = const $CopyWithPlaceholder(),
    Object? refId = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return ApiNotification(
      body: body == const $CopyWithPlaceholder() || body == null
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String,
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
      isRead: isRead == const $CopyWithPlaceholder() || isRead == null
          ? _value.isRead
          // ignore: cast_nullable_to_non_nullable
          : isRead as bool,
      refId: refId == const $CopyWithPlaceholder()
          ? _value.refId
          // ignore: cast_nullable_to_non_nullable
          : refId as String?,
      to: to == const $CopyWithPlaceholder() || to == null
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as User,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $ApiNotificationCopyWith on ApiNotification {
  /// Returns a callable class that can be used as follows: `instanceOfApiNotification.copyWith(...)` or like so:`instanceOfApiNotification.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ApiNotificationCWProxy get copyWith => _$ApiNotificationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiNotification _$ApiNotificationFromJson(Map<String, dynamic> json) =>
    ApiNotification(
      id: json['_id'] as String,
      to: User.fromJson(json['to'] as Map<String, dynamic>),
      from: User.fromJson(json['from'] as Map<String, dynamic>),
      body: json['body'] as String,
      refId: json['refId'] as String?,
      type: json['type'] as String,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ApiNotificationToJson(ApiNotification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'to': instance.to,
      'from': instance.from,
      'body': instance.body,
      'refId': instance.refId,
      'type': instance.type,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OnlineUserCWProxy {
  OnlineUser lastSeen(String? lastSeen);

  OnlineUser status(String? status);

  OnlineUser userId(String? userId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OnlineUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OnlineUser(...).copyWith(id: 12, name: "My name")
  /// ````
  OnlineUser call({
    String? lastSeen,
    String? status,
    String? userId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOnlineUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOnlineUser.copyWith.fieldName(...)`
class _$OnlineUserCWProxyImpl implements _$OnlineUserCWProxy {
  final OnlineUser _value;

  const _$OnlineUserCWProxyImpl(this._value);

  @override
  OnlineUser lastSeen(String? lastSeen) => this(lastSeen: lastSeen);

  @override
  OnlineUser status(String? status) => this(status: status);

  @override
  OnlineUser userId(String? userId) => this(userId: userId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OnlineUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OnlineUser(...).copyWith(id: 12, name: "My name")
  /// ````
  OnlineUser call({
    Object? lastSeen = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return OnlineUser(
      lastSeen: lastSeen == const $CopyWithPlaceholder()
          ? _value.lastSeen
          // ignore: cast_nullable_to_non_nullable
          : lastSeen as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $OnlineUserCopyWith on OnlineUser {
  /// Returns a callable class that can be used as follows: `instanceOfOnlineUser.copyWith(...)` or like so:`instanceOfOnlineUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OnlineUserCWProxy get copyWith => _$OnlineUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlineUser _$OnlineUserFromJson(Map<String, dynamic> json) => OnlineUser(
      userId: json['userId'] as String?,
      status: json['status'] as String?,
      lastSeen: json['lastSeen'] as String?,
    );

Map<String, dynamic> _$OnlineUserToJson(OnlineUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'status': instance.status,
      'lastSeen': instance.lastSeen,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OnlineUserCWProxy {
  OnlineUser userId(String? userId);

  OnlineUser status(String? status);

  OnlineUser lastSeen(String? lastSeen);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OnlineUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OnlineUser(...).copyWith(id: 12, name: "My name")
  /// ````
  OnlineUser call({
    String? userId,
    String? status,
    String? lastSeen,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOnlineUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOnlineUser.copyWith.fieldName(...)`
class _$OnlineUserCWProxyImpl implements _$OnlineUserCWProxy {
  const _$OnlineUserCWProxyImpl(this._value);

  final OnlineUser _value;

  @override
  OnlineUser userId(String? userId) => this(userId: userId);

  @override
  OnlineUser status(String? status) => this(status: status);

  @override
  OnlineUser lastSeen(String? lastSeen) => this(lastSeen: lastSeen);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OnlineUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OnlineUser(...).copyWith(id: 12, name: "My name")
  /// ````
  OnlineUser call({
    Object? userId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? lastSeen = const $CopyWithPlaceholder(),
  }) {
    return OnlineUser(
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      lastSeen: lastSeen == const $CopyWithPlaceholder()
          ? _value.lastSeen
          // ignore: cast_nullable_to_non_nullable
          : lastSeen as String?,
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationModelCWProxy {
  NotificationModel body(String body);

  NotificationModel createdAt(DateTime createdAt);

  NotificationModel from(User from);

  NotificationModel id(String id);

  NotificationModel isRead(bool isRead);

  NotificationModel refId(String? refId);

  NotificationModel to(User to);

  NotificationModel type(String type);

  NotificationModel updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationModel(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationModel call({
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationModel.copyWith.fieldName(...)`
class _$NotificationModelCWProxyImpl implements _$NotificationModelCWProxy {
  final NotificationModel _value;

  const _$NotificationModelCWProxyImpl(this._value);

  @override
  NotificationModel body(String body) => this(body: body);

  @override
  NotificationModel createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  NotificationModel from(User from) => this(from: from);

  @override
  NotificationModel id(String id) => this(id: id);

  @override
  NotificationModel isRead(bool isRead) => this(isRead: isRead);

  @override
  NotificationModel refId(String? refId) => this(refId: refId);

  @override
  NotificationModel to(User to) => this(to: to);

  @override
  NotificationModel type(String type) => this(type: type);

  @override
  NotificationModel updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationModel(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationModel call({
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
    return NotificationModel(
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

extension $NotificationModelCopyWith on NotificationModel {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationModel.copyWith(...)` or like so:`instanceOfNotificationModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationModelCWProxy get copyWith =>
      _$NotificationModelCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 12;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      id: fields[0] as String,
      to: fields[1] as User,
      from: fields[2] as User,
      body: fields[3] as String,
      refId: fields[4] as String?,
      type: fields[5] as String,
      isRead: fields[6] as bool,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.to)
      ..writeByte(2)
      ..write(obj.from)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.refId)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.isRead)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
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

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
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

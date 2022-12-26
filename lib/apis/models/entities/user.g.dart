// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCWProxy {
  User id(String id);

  User fname(String fname);

  User lname(String lname);

  User email(String email);

  User uname(String uname);

  User profession(String? profession);

  User avatar(MediaFile? avatar);

  User isPrivate(bool isPrivate);

  User followingStatus(String followingStatus);

  User accountStatus(String accountStatus);

  User isVerified(bool isVerified);

  User createdAt(DateTime createdAt);

  User updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `User(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ````
  User call({
    String? id,
    String? fname,
    String? lname,
    String? email,
    String? uname,
    String? profession,
    MediaFile? avatar,
    bool? isPrivate,
    String? followingStatus,
    String? accountStatus,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUser.copyWith.fieldName(...)`
class _$UserCWProxyImpl implements _$UserCWProxy {
  const _$UserCWProxyImpl(this._value);

  final User _value;

  @override
  User id(String id) => this(id: id);

  @override
  User fname(String fname) => this(fname: fname);

  @override
  User lname(String lname) => this(lname: lname);

  @override
  User email(String email) => this(email: email);

  @override
  User uname(String uname) => this(uname: uname);

  @override
  User profession(String? profession) => this(profession: profession);

  @override
  User avatar(MediaFile? avatar) => this(avatar: avatar);

  @override
  User isPrivate(bool isPrivate) => this(isPrivate: isPrivate);

  @override
  User followingStatus(String followingStatus) =>
      this(followingStatus: followingStatus);

  @override
  User accountStatus(String accountStatus) =>
      this(accountStatus: accountStatus);

  @override
  User isVerified(bool isVerified) => this(isVerified: isVerified);

  @override
  User createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  User updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `User(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ````
  User call({
    Object? id = const $CopyWithPlaceholder(),
    Object? fname = const $CopyWithPlaceholder(),
    Object? lname = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? uname = const $CopyWithPlaceholder(),
    Object? profession = const $CopyWithPlaceholder(),
    Object? avatar = const $CopyWithPlaceholder(),
    Object? isPrivate = const $CopyWithPlaceholder(),
    Object? followingStatus = const $CopyWithPlaceholder(),
    Object? accountStatus = const $CopyWithPlaceholder(),
    Object? isVerified = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return User(
      id: id == const $CopyWithPlaceholder() || id == null
          // ignore: unnecessary_non_null_assertion
          ? _value.id!
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      fname: fname == const $CopyWithPlaceholder() || fname == null
          // ignore: unnecessary_non_null_assertion
          ? _value.fname!
          // ignore: cast_nullable_to_non_nullable
          : fname as String,
      lname: lname == const $CopyWithPlaceholder() || lname == null
          // ignore: unnecessary_non_null_assertion
          ? _value.lname!
          // ignore: cast_nullable_to_non_nullable
          : lname as String,
      email: email == const $CopyWithPlaceholder() || email == null
          // ignore: unnecessary_non_null_assertion
          ? _value.email!
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      uname: uname == const $CopyWithPlaceholder() || uname == null
          // ignore: unnecessary_non_null_assertion
          ? _value.uname!
          // ignore: cast_nullable_to_non_nullable
          : uname as String,
      profession: profession == const $CopyWithPlaceholder()
          ? _value.profession
          // ignore: cast_nullable_to_non_nullable
          : profession as String?,
      avatar: avatar == const $CopyWithPlaceholder()
          ? _value.avatar
          // ignore: cast_nullable_to_non_nullable
          : avatar as MediaFile?,
      isPrivate: isPrivate == const $CopyWithPlaceholder() || isPrivate == null
          // ignore: unnecessary_non_null_assertion
          ? _value.isPrivate!
          // ignore: cast_nullable_to_non_nullable
          : isPrivate as bool,
      followingStatus: followingStatus == const $CopyWithPlaceholder() ||
              followingStatus == null
          // ignore: unnecessary_non_null_assertion
          ? _value.followingStatus!
          // ignore: cast_nullable_to_non_nullable
          : followingStatus as String,
      accountStatus:
          accountStatus == const $CopyWithPlaceholder() || accountStatus == null
              // ignore: unnecessary_non_null_assertion
              ? _value.accountStatus!
              // ignore: cast_nullable_to_non_nullable
              : accountStatus as String,
      isVerified:
          isVerified == const $CopyWithPlaceholder() || isVerified == null
              // ignore: unnecessary_non_null_assertion
              ? _value.isVerified!
              // ignore: cast_nullable_to_non_nullable
              : isVerified as bool,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          // ignore: unnecessary_non_null_assertion
          ? _value.createdAt!
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          // ignore: unnecessary_non_null_assertion
          ? _value.updatedAt!
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $UserCopyWith on User {
  /// Returns a callable class that can be used as follows: `instanceOfUser.copyWith(...)` or like so:`instanceOfUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserCWProxy get copyWith => _$UserCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      fname: fields[1] as String,
      lname: fields[2] as String,
      email: fields[3] as String,
      uname: fields[4] as String,
      profession: fields[8] as String?,
      avatar: fields[5] as MediaFile?,
      isPrivate: fields[9] as bool,
      followingStatus: fields[6] as String,
      accountStatus: fields[7] as String,
      isVerified: fields[10] as bool,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fname)
      ..writeByte(2)
      ..write(obj.lname)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.uname)
      ..writeByte(5)
      ..write(obj.avatar)
      ..writeByte(6)
      ..write(obj.followingStatus)
      ..writeByte(7)
      ..write(obj.accountStatus)
      ..writeByte(8)
      ..write(obj.profession)
      ..writeByte(9)
      ..write(obj.isPrivate)
      ..writeByte(10)
      ..write(obj.isVerified)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      uname: json['uname'] as String,
      profession: json['profession'] as String?,
      avatar: json['avatar'] == null
          ? null
          : MediaFile.fromJson(json['avatar'] as Map<String, dynamic>),
      isPrivate: json['isPrivate'] as bool,
      followingStatus: json['followingStatus'] as String,
      accountStatus: json['accountStatus'] as String,
      isVerified: json['isVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'uname': instance.uname,
      'avatar': instance.avatar,
      'followingStatus': instance.followingStatus,
      'accountStatus': instance.accountStatus,
      'profession': instance.profession,
      'isPrivate': instance.isPrivate,
      'isVerified': instance.isVerified,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

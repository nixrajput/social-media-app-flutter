// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

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
      publicKeys: fields[11] as ServerKey?,
      createdAt: fields[12] as DateTime,
      updatedAt: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(14)
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
      ..write(obj.publicKeys)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
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
      publicKeys: json['publicKeys'] == null
          ? null
          : ServerKey.fromJson(json['publicKeys'] as Map<String, dynamic>),
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
      'publicKeys': instance.publicKeys,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

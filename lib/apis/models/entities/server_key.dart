import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'server_key.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypeId.serverKey)
class ServerKey {
  ServerKey({
    required this.identityPublicKey,
    required this.registrationId,
    required this.preKey,
    required this.signedPreKey,
  });

  factory ServerKey.fromJson(Map<String, dynamic> json) =>
      _$ServerKeyFromJson(json);

  Map<String, dynamic> toJson() => _$ServerKeyToJson(this);

  @JsonKey(name: 'identityPublicKey')
  @HiveField(0)
  final String identityPublicKey;

  @JsonKey(name: 'registrationId')
  @HiveField(1)
  final String registrationId;

  @JsonKey(name: 'preKey')
  @HiveField(2)
  final ServerPreKey preKey;

  @JsonKey(name: 'signedPreKey')
  @HiveField(3)
  final ServerSignedPreKey signedPreKey;
}

@JsonSerializable()
class ServerPreKey extends HiveObject {
  ServerPreKey({required this.keyId, required this.publicKey});

  factory ServerPreKey.fromJson(Map<String, dynamic> json) =>
      _$ServerPreKeyFromJson(json);

  Map<String, dynamic> toJson() => _$ServerPreKeyToJson(this);

  @JsonKey(name: 'keyId')
  @HiveField(0)
  final String keyId;

  @JsonKey(name: 'publicKey')
  @HiveField(1)
  final String publicKey;
}

@JsonSerializable()
class ServerSignedPreKey extends HiveObject {
  ServerSignedPreKey({
    required this.keyId,
    required this.publicKey,
    required this.signature,
  });

  factory ServerSignedPreKey.fromJson(Map<String, dynamic> json) =>
      _$ServerSignedPreKeyFromJson(json);

  Map<String, dynamic> toJson() => _$ServerSignedPreKeyToJson(this);

  @JsonKey(name: 'keyId')
  @HiveField(0)
  final String keyId;

  @JsonKey(name: 'publicKey')
  @HiveField(1)
  final String publicKey;

  @JsonKey(name: 'signature')
  @HiveField(2)
  final String signature;
}

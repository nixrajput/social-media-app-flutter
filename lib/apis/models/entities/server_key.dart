import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'server_key.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypeId.serverKey)
class ServerKey extends HiveObject {
  ServerKey({
    required this.registrationId,
    required this.preKeyId,
    required this.preKeyPublicKey,
    required this.signedPreKeyId,
    required this.signedPreKeyPublicKey,
    required this.signedPreKeySignature,
    required this.identityKeyPairPublicKey,
  });

  factory ServerKey.fromJson(Map<String, dynamic> json) =>
      _$ServerKeyFromJson(json);

  Map<String, dynamic> toJson() => _$ServerKeyToJson(this);

  @JsonKey(name: 'registrationId')
  @HiveField(0)
  final String registrationId;

  @JsonKey(name: 'preKeyId')
  @HiveField(1)
  final String preKeyId;

  @JsonKey(name: 'preKeyPublicKey')
  @HiveField(2)
  final String preKeyPublicKey;

  @JsonKey(name: 'signedPreKeyId')
  @HiveField(3)
  final String signedPreKeyId;

  @JsonKey(name: 'signedPreKeyPublicKey')
  @HiveField(4)
  final String signedPreKeyPublicKey;

  @JsonKey(name: 'signedPreKeySignature')
  @HiveField(5)
  final String signedPreKeySignature;

  @JsonKey(name: 'identityKeyPairPublicKey')
  @HiveField(6)
  final String identityKeyPairPublicKey;
}

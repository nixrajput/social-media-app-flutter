import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'secret_key.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypeId.secretKey)
class SecretKey extends HiveObject {
  SecretKey({
    required this.identityKeyPair,
    required this.registrationId,
    required this.preKeys,
    required this.signedPreKey,
  });

  factory SecretKey.fromJson(Map<String, dynamic> json) =>
      _$SecretKeyFromJson(json);

  Map<String, dynamic> toJson() => _$SecretKeyToJson(this);

  @JsonKey(name: 'identityKeyPair')
  @HiveField(0)
  final String identityKeyPair;

  @JsonKey(name: 'registrationId')
  @HiveField(1)
  final String registrationId;

  @JsonKey(name: 'preKeys')
  @HiveField(2)
  final List<String> preKeys;

  @JsonKey(name: 'signedPreKey')
  @HiveField(3)
  final String signedPreKey;
}

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'auth_response.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.auth)
class AuthResponse {
  AuthResponse({
    this.success,
    this.message,
    this.token,
    this.expiresAt,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @JsonKey(name: 'success')
  @HiveField(0)
  final bool? success;

  @JsonKey(name: 'message')
  @HiveField(1)
  final String? message;

  @JsonKey(name: 'token')
  @HiveField(2)
  final String? token;

  @JsonKey(name: 'expiresAt')
  @HiveField(3)
  final int? expiresAt;
}

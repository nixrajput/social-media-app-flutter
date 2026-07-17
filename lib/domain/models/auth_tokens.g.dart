// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => _AuthTokens(
  accessToken: json['accessToken'] as String,
  accessExpiresAt: DateTime.parse(json['accessExpiresAt'] as String),
  refreshToken: json['refreshToken'] as String,
  refreshExpiresAt: DateTime.parse(json['refreshExpiresAt'] as String),
);

Map<String, dynamic> _$AuthTokensToJson(_AuthTokens instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'accessExpiresAt': instance.accessExpiresAt.toIso8601String(),
      'refreshToken': instance.refreshToken,
      'refreshExpiresAt': instance.refreshExpiresAt.toIso8601String(),
    };

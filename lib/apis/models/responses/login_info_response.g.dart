// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfoResponse _$LoginInfoResponseFromJson(Map<String, dynamic> json) =>
    LoginInfoResponse(
      success: json['success'] as bool?,
      result: json['result'] == null
          ? null
          : LoginInfo.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginInfoResponseToJson(LoginInfoResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

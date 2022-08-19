// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfoResponse _$DeviceInfoResponseFromJson(Map<String, dynamic> json) =>
    DeviceInfoResponse(
      success: json['success'] as bool?,
      count: json['count'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => DeviceInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceInfoResponseToJson(DeviceInfoResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'results': instance.results,
    };

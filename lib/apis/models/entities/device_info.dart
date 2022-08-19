import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/location_info.dart';

part 'device_info.g.dart';

@JsonSerializable()
class DeviceInfo extends Equatable {
  const DeviceInfo({
    this.id,
    this.user,
    this.deviceId,
    this.deviceInfo,
    this.locationInfo,
    this.isActive,
    this.lastActive,
    this.createdAt,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'user')
  final String? user;

  @JsonKey(name: 'deviceId')
  final String? deviceId;

  @JsonKey(name: 'deviceInfo')
  final Map<String, dynamic>? deviceInfo;

  @JsonKey(name: 'locationInfo')
  final LocationInfo? locationInfo;

  @JsonKey(name: 'isActive')
  final bool? isActive;

  @JsonKey(name: 'lastActive')
  final String? lastActive;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        user,
        deviceId,
        deviceInfo,
        locationInfo,
        isActive,
        lastActive,
        createdAt,
      ];
}

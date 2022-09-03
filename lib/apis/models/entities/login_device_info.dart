import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/location_info.dart';

part 'login_device_info.g.dart';

@JsonSerializable()
class LoginDeviceInfo extends Equatable {
  const LoginDeviceInfo({
    this.id,
    this.user,
    this.deviceId,
    this.deviceInfo,
    this.locationInfo,
    this.isActive,
    this.lastActive,
    this.createdAt,
  });

  factory LoginDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginDeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDeviceInfoToJson(this);

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

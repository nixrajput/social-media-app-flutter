import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/login_device_info.dart';

part 'device_info_response.g.dart';

@JsonSerializable()
class DeviceInfoResponse extends Equatable {
  const DeviceInfoResponse({
    this.success,
    this.count,
    this.results,
  });

  factory DeviceInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'results')
  final List<LoginDeviceInfo>? results;

  @override
  List<Object?> get props => <Object?>[
        success,
        count,
        results,
      ];
}

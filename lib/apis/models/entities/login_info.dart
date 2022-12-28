import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_info.g.dart';

@CopyWith()
@JsonSerializable()
class LoginInfo {
  LoginInfo({
    this.id,
    this.user,
    this.deviceId,
    this.ip,
    this.deviceName,
    this.deviceModel,
    this.deviceBrand,
    this.deviceManufacturer,
    this.deviceOs,
    this.deviceOsVersion,
    this.deviceType,
    this.city,
    this.region,
    this.regionName,
    this.country,
    this.countryCode,
    this.continent,
    this.continentCode,
    this.lat,
    this.lon,
    this.zip,
    this.timezone,
    this.currency,
    this.isp,
    this.org,
    this.resultAs,
    this.asname,
    this.reverse,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);

  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'user')
  String? user;

  @JsonKey(name: 'deviceId')
  String? deviceId;

  @JsonKey(name: 'ip')
  String? ip;

  @JsonKey(name: 'deviceName')
  String? deviceName;

  @JsonKey(name: 'deviceModel')
  String? deviceModel;

  @JsonKey(name: 'deviceBrand')
  String? deviceBrand;

  @JsonKey(name: 'deviceManufacturer')
  String? deviceManufacturer;

  @JsonKey(name: 'deviceOs')
  String? deviceOs;

  @JsonKey(name: 'deviceOsVersion')
  String? deviceOsVersion;

  @JsonKey(name: 'deviceType')
  String? deviceType;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'region')
  String? region;

  @JsonKey(name: 'regionName')
  String? regionName;

  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'countryCode')
  String? countryCode;

  @JsonKey(name: 'continent')
  String? continent;

  @JsonKey(name: 'continentCode')
  String? continentCode;

  @JsonKey(name: 'lat')
  double? lat;

  @JsonKey(name: 'lon')
  double? lon;

  @JsonKey(name: 'zip')
  String? zip;

  @JsonKey(name: 'timezone')
  String? timezone;

  @JsonKey(name: 'currency')
  String? currency;

  @JsonKey(name: 'isp')
  String? isp;

  @JsonKey(name: 'org')
  String? org;

  @JsonKey(name: 'resultAs')
  String? resultAs;

  @JsonKey(name: 'asname')
  String? asname;

  @JsonKey(name: 'reverse')
  String? reverse;

  @JsonKey(name: 'isActive')
  bool? isActive;

  @JsonKey(name: 'createdAt')
  DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
}

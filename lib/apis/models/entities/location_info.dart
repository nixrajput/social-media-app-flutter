import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_info.g.dart';

@JsonSerializable()
class LocationInfo extends Equatable {
  const LocationInfo({
    this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.locationInfoAs,
    this.ip,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
      _$LocationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationInfoToJson(this);

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'countryCode')
  final String? countryCode;

  @JsonKey(name: 'region')
  final String? region;

  @JsonKey(name: 'regionName')
  final String? regionName;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'zip')
  final String? zip;

  @JsonKey(name: 'lat')
  final double? lat;

  @JsonKey(name: 'lon')
  final double? lon;

  @JsonKey(name: 'timezone')
  final String? timezone;

  @JsonKey(name: 'isp')
  final String? isp;

  @JsonKey(name: 'org')
  final String? org;

  @JsonKey(name: 'locationInfoAs')
  final String? locationInfoAs;

  @JsonKey(name: 'query')
  final String? ip;

  @override
  List<Object?> get props => <Object?>[
        status,
        country,
        countryCode,
        region,
        regionName,
        city,
        zip,
        lat,
        lon,
        timezone,
        isp,
        org,
        locationInfoAs,
        ip,
      ];
}

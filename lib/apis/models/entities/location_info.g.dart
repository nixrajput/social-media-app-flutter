// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LocationInfoCWProxy {
  LocationInfo city(String? city);

  LocationInfo country(String? country);

  LocationInfo countryCode(String? countryCode);

  LocationInfo ip(String? ip);

  LocationInfo isp(String? isp);

  LocationInfo lat(double? lat);

  LocationInfo locationInfoAs(String? locationInfoAs);

  LocationInfo lon(double? lon);

  LocationInfo org(String? org);

  LocationInfo region(String? region);

  LocationInfo regionName(String? regionName);

  LocationInfo status(String? status);

  LocationInfo timezone(String? timezone);

  LocationInfo zip(String? zip);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LocationInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LocationInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  LocationInfo call({
    String? city,
    String? country,
    String? countryCode,
    String? ip,
    String? isp,
    double? lat,
    String? locationInfoAs,
    double? lon,
    String? org,
    String? region,
    String? regionName,
    String? status,
    String? timezone,
    String? zip,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLocationInfo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLocationInfo.copyWith.fieldName(...)`
class _$LocationInfoCWProxyImpl implements _$LocationInfoCWProxy {
  final LocationInfo _value;

  const _$LocationInfoCWProxyImpl(this._value);

  @override
  LocationInfo city(String? city) => this(city: city);

  @override
  LocationInfo country(String? country) => this(country: country);

  @override
  LocationInfo countryCode(String? countryCode) =>
      this(countryCode: countryCode);

  @override
  LocationInfo ip(String? ip) => this(ip: ip);

  @override
  LocationInfo isp(String? isp) => this(isp: isp);

  @override
  LocationInfo lat(double? lat) => this(lat: lat);

  @override
  LocationInfo locationInfoAs(String? locationInfoAs) =>
      this(locationInfoAs: locationInfoAs);

  @override
  LocationInfo lon(double? lon) => this(lon: lon);

  @override
  LocationInfo org(String? org) => this(org: org);

  @override
  LocationInfo region(String? region) => this(region: region);

  @override
  LocationInfo regionName(String? regionName) => this(regionName: regionName);

  @override
  LocationInfo status(String? status) => this(status: status);

  @override
  LocationInfo timezone(String? timezone) => this(timezone: timezone);

  @override
  LocationInfo zip(String? zip) => this(zip: zip);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LocationInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LocationInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  LocationInfo call({
    Object? city = const $CopyWithPlaceholder(),
    Object? country = const $CopyWithPlaceholder(),
    Object? countryCode = const $CopyWithPlaceholder(),
    Object? ip = const $CopyWithPlaceholder(),
    Object? isp = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? locationInfoAs = const $CopyWithPlaceholder(),
    Object? lon = const $CopyWithPlaceholder(),
    Object? org = const $CopyWithPlaceholder(),
    Object? region = const $CopyWithPlaceholder(),
    Object? regionName = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? timezone = const $CopyWithPlaceholder(),
    Object? zip = const $CopyWithPlaceholder(),
  }) {
    return LocationInfo(
      city: city == const $CopyWithPlaceholder()
          ? _value.city
          // ignore: cast_nullable_to_non_nullable
          : city as String?,
      country: country == const $CopyWithPlaceholder()
          ? _value.country
          // ignore: cast_nullable_to_non_nullable
          : country as String?,
      countryCode: countryCode == const $CopyWithPlaceholder()
          ? _value.countryCode
          // ignore: cast_nullable_to_non_nullable
          : countryCode as String?,
      ip: ip == const $CopyWithPlaceholder()
          ? _value.ip
          // ignore: cast_nullable_to_non_nullable
          : ip as String?,
      isp: isp == const $CopyWithPlaceholder()
          ? _value.isp
          // ignore: cast_nullable_to_non_nullable
          : isp as String?,
      lat: lat == const $CopyWithPlaceholder()
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as double?,
      locationInfoAs: locationInfoAs == const $CopyWithPlaceholder()
          ? _value.locationInfoAs
          // ignore: cast_nullable_to_non_nullable
          : locationInfoAs as String?,
      lon: lon == const $CopyWithPlaceholder()
          ? _value.lon
          // ignore: cast_nullable_to_non_nullable
          : lon as double?,
      org: org == const $CopyWithPlaceholder()
          ? _value.org
          // ignore: cast_nullable_to_non_nullable
          : org as String?,
      region: region == const $CopyWithPlaceholder()
          ? _value.region
          // ignore: cast_nullable_to_non_nullable
          : region as String?,
      regionName: regionName == const $CopyWithPlaceholder()
          ? _value.regionName
          // ignore: cast_nullable_to_non_nullable
          : regionName as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      timezone: timezone == const $CopyWithPlaceholder()
          ? _value.timezone
          // ignore: cast_nullable_to_non_nullable
          : timezone as String?,
      zip: zip == const $CopyWithPlaceholder()
          ? _value.zip
          // ignore: cast_nullable_to_non_nullable
          : zip as String?,
    );
  }
}

extension $LocationInfoCopyWith on LocationInfo {
  /// Returns a callable class that can be used as follows: `instanceOfLocationInfo.copyWith(...)` or like so:`instanceOfLocationInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LocationInfoCWProxy get copyWith => _$LocationInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationInfo _$LocationInfoFromJson(Map<String, dynamic> json) => LocationInfo(
      status: json['status'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
      region: json['region'] as String?,
      regionName: json['regionName'] as String?,
      city: json['city'] as String?,
      zip: json['zip'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      timezone: json['timezone'] as String?,
      isp: json['isp'] as String?,
      org: json['org'] as String?,
      locationInfoAs: json['locationInfoAs'] as String?,
      ip: json['query'] as String?,
    );

Map<String, dynamic> _$LocationInfoToJson(LocationInfo instance) =>
    <String, dynamic>{
      'status': instance.status,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'region': instance.region,
      'regionName': instance.regionName,
      'city': instance.city,
      'zip': instance.zip,
      'lat': instance.lat,
      'lon': instance.lon,
      'timezone': instance.timezone,
      'isp': instance.isp,
      'org': instance.org,
      'locationInfoAs': instance.locationInfoAs,
      'query': instance.ip,
    };

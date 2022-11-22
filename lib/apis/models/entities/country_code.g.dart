// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_code.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CountryCodeCWProxy {
  CountryCode code(String code);

  CountryCode dialCode(String dialCode);

  CountryCode name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CountryCode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CountryCode(...).copyWith(id: 12, name: "My name")
  /// ````
  CountryCode call({
    String? code,
    String? dialCode,
    String? name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCountryCode.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCountryCode.copyWith.fieldName(...)`
class _$CountryCodeCWProxyImpl implements _$CountryCodeCWProxy {
  final CountryCode _value;

  const _$CountryCodeCWProxyImpl(this._value);

  @override
  CountryCode code(String code) => this(code: code);

  @override
  CountryCode dialCode(String dialCode) => this(dialCode: dialCode);

  @override
  CountryCode name(String name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CountryCode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CountryCode(...).copyWith(id: 12, name: "My name")
  /// ````
  CountryCode call({
    Object? code = const $CopyWithPlaceholder(),
    Object? dialCode = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return CountryCode(
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      dialCode: dialCode == const $CopyWithPlaceholder() || dialCode == null
          ? _value.dialCode
          // ignore: cast_nullable_to_non_nullable
          : dialCode as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $CountryCodeCopyWith on CountryCode {
  /// Returns a callable class that can be used as follows: `instanceOfCountryCode.copyWith(...)` or like so:`instanceOfCountryCode.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CountryCodeCWProxy get copyWith => _$CountryCodeCWProxyImpl(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_code.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CountryCodeCWProxy {
  CountryCode name(String name);

  CountryCode code(String code);

  CountryCode dialCode(String dialCode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CountryCode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CountryCode(...).copyWith(id: 12, name: "My name")
  /// ````
  CountryCode call({
    String? name,
    String? code,
    String? dialCode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCountryCode.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCountryCode.copyWith.fieldName(...)`
class _$CountryCodeCWProxyImpl implements _$CountryCodeCWProxy {
  const _$CountryCodeCWProxyImpl(this._value);

  final CountryCode _value;

  @override
  CountryCode name(String name) => this(name: name);

  @override
  CountryCode code(String code) => this(code: code);

  @override
  CountryCode dialCode(String dialCode) => this(dialCode: dialCode);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CountryCode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CountryCode(...).copyWith(id: 12, name: "My name")
  /// ````
  CountryCode call({
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? dialCode = const $CopyWithPlaceholder(),
  }) {
    return CountryCode(
      name: name == const $CopyWithPlaceholder() || name == null
          // ignore: unnecessary_non_null_assertion
          ? _value.name!
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      code: code == const $CopyWithPlaceholder() || code == null
          // ignore: unnecessary_non_null_assertion
          ? _value.code!
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      dialCode: dialCode == const $CopyWithPlaceholder() || dialCode == null
          // ignore: unnecessary_non_null_assertion
          ? _value.dialCode!
          // ignore: cast_nullable_to_non_nullable
          : dialCode as String,
    );
  }
}

extension $CountryCodeCopyWith on CountryCode {
  /// Returns a callable class that can be used as follows: `instanceOfCountryCode.copyWith(...)` or like so:`instanceOfCountryCode.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CountryCodeCWProxy get copyWith => _$CountryCodeCWProxyImpl(this);
}

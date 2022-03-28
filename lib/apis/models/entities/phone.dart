import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

@JsonSerializable()
class Phone {
  Phone({
    this.countryCode,
    this.phoneNo,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneToJson(this);

  @JsonKey(name: 'countryCode')
  String? countryCode;

  @JsonKey(name: 'phoneNo')
  String? phoneNo;
}

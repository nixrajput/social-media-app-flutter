import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

@JsonSerializable()
class Phone extends Equatable {
  const Phone({
    this.countryCode,
    this.phoneNo,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneToJson(this);

  @JsonKey(name: 'countryCode')
  final String? countryCode;

  @JsonKey(name: 'phoneNo')
  final String? phoneNo;

  @override
  List<Object?> get props => <Object?>[
        countryCode,
        phoneNo,
      ];
}

import 'dart:convert';

class Phone {
  Phone({
    this.countryCode,
    this.phoneNo,
  });

  final String? countryCode;
  final String? phoneNo;

  factory Phone.fromRawJson(String str) => Phone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        countryCode: json["countryCode"],
        phoneNo: json["phoneNo"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "phoneNo": phoneNo,
      };
}

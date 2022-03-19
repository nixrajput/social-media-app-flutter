import 'dart:convert';

class LoginModel {
  LoginModel({
    this.success,
    this.message,
    this.token,
    this.expiresAt,
  });

  final bool? success;
  final String? message;
  final String? token;
  final String? expiresAt;

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        token: json["token"],
        expiresAt: json["expiresAt"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
        "expiresAt": expiresAt,
      };
}

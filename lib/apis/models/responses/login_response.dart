import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends Equatable {
  const LoginResponse({
    this.success,
    this.message,
    this.token,
    this.expiresAt,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'expiresAt')
  final int? expiresAt;

  @override
  List<Object?> get props => <Object?>[
        success,
        message,
        token,
        expiresAt,
      ];
}

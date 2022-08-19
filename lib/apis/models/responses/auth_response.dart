import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse extends Equatable {
  const AuthResponse({
    this.success,
    this.message,
    this.token,
    this.expiresAt,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

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

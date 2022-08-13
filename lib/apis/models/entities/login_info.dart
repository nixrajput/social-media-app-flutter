import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_info.g.dart';

@JsonSerializable()
class LoginInfo extends Equatable {
  const LoginInfo({
    required this.id,
    this.user,
    this.devices,
    required this.createdAt,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'user')
  final String? user;

  @JsonKey(name: 'devices')
  final List<Map<String, dynamic>>? devices;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        user,
        devices,
        createdAt,
      ];
}

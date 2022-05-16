import 'package:json_annotation/json_annotation.dart';

part 'login_info.g.dart';

@JsonSerializable()
class LoginInfo {
  LoginInfo({
    required this.id,
    this.user,
    this.devices,
    required this.createdAt,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'user')
  String? user;

  @JsonKey(name: 'devices')
  List<Map<String, dynamic>>? devices;

  @JsonKey(name: 'createdAt')
  DateTime createdAt;
}

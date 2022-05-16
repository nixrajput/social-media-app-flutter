import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/login_info.dart';

part 'login_info_response.g.dart';

@JsonSerializable()
class LoginInfoResponse {
  LoginInfoResponse({
    this.success,
    this.result,
  });

  factory LoginInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInfoResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'result')
  LoginInfo? result;
}

import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse {
  CommonResponse({
    this.success,
    this.message,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'message')
  String? message;
}

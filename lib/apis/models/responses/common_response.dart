import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse extends Equatable {
  const CommonResponse({
    this.success,
    this.message,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  @override
  List<Object?> get props => <Object?>[
        success,
        message,
      ];
}

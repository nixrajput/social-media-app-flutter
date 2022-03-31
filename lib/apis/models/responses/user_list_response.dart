import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'user_list_response.g.dart';

@JsonSerializable()
class UserListResponse {
  UserListResponse({
    this.success,
    this.results,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'results')
  List<User>? results;
}

import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user_details.dart';

part 'user_details_response.g.dart';

@JsonSerializable()
class UserDetailsResponse {
  UserDetailsResponse({
    this.success,
    this.user,
  });

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'user')
  UserDetails? user;
}

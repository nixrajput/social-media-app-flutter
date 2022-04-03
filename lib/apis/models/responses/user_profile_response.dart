import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user_profile.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  UserProfileResponse({
    this.success,
    this.user,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'user')
  UserProfile? user;
}

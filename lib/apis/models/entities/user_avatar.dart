import 'package:json_annotation/json_annotation.dart';

part 'user_avatar.g.dart';

@JsonSerializable()
class UserAvatar {
  UserAvatar({
    this.publicId,
    this.url,
  });

  factory UserAvatar.fromJson(Map<String, dynamic> json) =>
      _$UserAvatarFromJson(json);

  Map<String, dynamic> toJson() => _$UserAvatarToJson(this);

  @JsonKey(name: 'public_id')
  String? publicId;

  @JsonKey(name: 'url')
  String? url;
}

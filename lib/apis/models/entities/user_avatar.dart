import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_avatar.g.dart';

@JsonSerializable()
class UserAvatar extends Equatable {
  const UserAvatar({
    this.publicId,
    this.url,
  });

  factory UserAvatar.fromJson(Map<String, dynamic> json) =>
      _$UserAvatarFromJson(json);

  Map<String, dynamic> toJson() => _$UserAvatarToJson(this);

  @JsonKey(name: 'public_id')
  final String? publicId;

  @JsonKey(name: 'url')
  final String? url;

  @override
  List<Object?> get props => <Object?>[];
}

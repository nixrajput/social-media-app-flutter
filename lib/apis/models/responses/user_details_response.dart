import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user_details.dart';

part 'user_details_response.g.dart';

@JsonSerializable()
class UserDetailsResponse extends Equatable {
  const UserDetailsResponse({
    this.success,
    this.user,
  });

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'user')
  final UserDetails? user;

  @override
  List<Object?> get props => <Object?>[
        success,
        user,
      ];
}

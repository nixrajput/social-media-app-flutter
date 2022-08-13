import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/profile.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse extends Equatable {
  const ProfileResponse({
    this.success,
    this.user,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'user')
  final Profile? user;

  @override
  List<Object?> get props => <Object?>[
        success,
        user,
      ];
}

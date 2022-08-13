import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'follower_list_response.g.dart';

@JsonSerializable()
class FollowerListResponse extends Equatable {
  const FollowerListResponse({
    this.success,
    this.count,
    this.results,
  });

  factory FollowerListResponse.fromJson(Map<String, dynamic> json) =>
      _$FollowerListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerListResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'results')
  final List<User>? results;

  @override
  List<Object?> get props => <Object?>[
        success,
        count,
        results,
      ];
}

import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/follower.dart';

part 'follower_list_response.g.dart';

@JsonSerializable()
class FollowerListResponse {
  FollowerListResponse({
    this.success,
    this.results,
  });

  factory FollowerListResponse.fromJson(Map<String, dynamic> json) =>
      _$FollowerListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerListResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'results')
  List<Follower>? results;
}

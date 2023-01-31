import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'blocked_users_response.g.dart';

@JsonSerializable()
class BlockedUsersResponse {
  const BlockedUsersResponse({
    this.success,
    this.currentPage,
    this.totalPages,
    this.limit,
    this.hasPrevPage,
    this.prevPage,
    this.hasNextPage,
    this.nextPage,
    this.length,
    this.results,
  });

  factory BlockedUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$BlockedUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlockedUsersResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'currentPage')
  final int? currentPage;

  @JsonKey(name: 'totalPages')
  final int? totalPages;

  @JsonKey(name: 'limit')
  final int? limit;

  @JsonKey(name: 'hasPrevPage')
  final bool? hasPrevPage;

  @JsonKey(name: 'prevPage')
  final String? prevPage;

  @JsonKey(name: 'hasNextPage')
  final bool? hasNextPage;

  @JsonKey(name: 'nextPage')
  final String? nextPage;

  @JsonKey(name: 'length')
  final int? length;

  @JsonKey(name: 'results')
  final List<User>? results;
}

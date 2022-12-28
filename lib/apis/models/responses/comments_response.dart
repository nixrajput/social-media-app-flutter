import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';

part 'comments_response.g.dart';

@JsonSerializable()
class CommentsResponse extends Equatable {
  const CommentsResponse({
    this.success,
    this.currentPage,
    this.totalPages,
    this.limit,
    this.hasPrevPage,
    this.prevPage,
    this.hasNextPage,
    this.nextPage,
    this.results,
  });

  factory CommentsResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsResponseToJson(this);

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

  @JsonKey(name: 'results')
  final List<Comment>? results;

  @override
  List<Object?> get props => <Object?>[
        success,
        currentPage,
        totalPages,
        limit,
        hasPrevPage,
        prevPage,
        hasNextPage,
        nextPage,
        results,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/user.dart';

part 'follower.g.dart';

@JsonSerializable()
class Follower extends Equatable {
  const Follower({
    required this.id,
    required this.user,
    required this.createdAt,
  });

  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        user,
        createdAt,
      ];
}

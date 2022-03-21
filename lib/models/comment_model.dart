import 'dart:convert';

class CommentModel {
  CommentModel({
    this.id,
    this.comment,
    this.user,
    this.post,
    this.likes,
    this.createdAt,
  });

  final String? id;
  final String? comment;
  final String? user;
  final String? post;
  final List<dynamic>? likes;
  final DateTime? createdAt;

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["_id"],
        comment: json["comment"],
        user: json["user"],
        post: json["post"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comment": comment,
        "user": user,
        "post": post,
        "likes": List<dynamic>.from(likes!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
      };
}

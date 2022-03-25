// ignore_for_file: unnecessary_lambdas

import 'dart:convert';

import 'avatar_model.dart';
import 'image_model.dart';

class PostModel {
  PostModel({
    this.success,
    this.count,
    this.posts,
  });

  final bool? success;
  final int? count;
  final List<Post>? posts;

  factory PostModel.fromRawJson(String str) =>
      PostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        success: json["success"],
        count: json["count"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    this.id,
    this.caption,
    this.images,
    this.owner,
    this.likes,
    this.comments,
    this.postStatus,
    this.createdAt,
  });

  final String? id;
  final String? caption;
  final List<Image>? images;
  final Owner? owner;
  final List<dynamic>? likes;
  final List<dynamic>? comments;
  final String? postStatus;
  final DateTime? createdAt;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        caption: json["caption"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        owner: Owner.fromJson(json["owner"]),
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        postStatus: json["postStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "caption": caption,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "owner": owner!.toJson(),
        "likes": List<dynamic>.from(likes!.map((x) => x)),
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "postStatus": postStatus,
        "createdAt": createdAt!.toIso8601String(),
      };
}

class Owner {
  Owner({
    this.avatar,
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
  });

  final Avatar? avatar;
  final String id;
  final String fname;
  final String lname;
  final String email;
  final String uname;

  factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
        id: json["_id"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        uname: json["uname"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar == null ? null : avatar!.toJson(),
        "_id": id,
        "fname": fname,
        "lname": lname,
        "email": email,
        "uname": uname,
      };
}

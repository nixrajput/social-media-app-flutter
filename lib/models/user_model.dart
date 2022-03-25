// ignore_for_file: unnecessary_lambdas

import 'dart:convert';

import 'avatar_model.dart';
import 'image_model.dart';
import 'phone_model.dart';

class UserModel {
  UserModel({
    this.success,
    this.user,
  });

  final bool? success;
  final User? user;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user!.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
    required this.posts,
    required this.followers,
    required this.following,
    required this.role,
    required this.accountStatus,
    required this.createdAt,
    required this.isVerified,
    this.phone,
    this.gender,
    this.dob,
    this.about,
    this.avatar,
    this.expiresAt,
    this.token,
    this.resetPasswordToken,
    this.resetPasswordExpire,
    this.lastActive,
  });

  final String id;
  final String fname;
  final String lname;
  final String email;
  final String uname;
  final List<UserPost> posts;
  final List<dynamic> followers;
  final List<dynamic> following;
  final String role;
  final String accountStatus;
  final DateTime createdAt;
  final bool isVerified;
  final Phone? phone;
  final String? gender;
  final String? dob;
  final String? about;
  final Avatar? avatar;
  final String? expiresAt;
  final String? token;
  final String? resetPasswordToken;
  final String? resetPasswordExpire;
  final DateTime? lastActive;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        uname: json["uname"],
        avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
        phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
        gender: json["gender"],
        dob: json["dob"],
        about: json["about"],
        posts:
            List<UserPost>.from(json['posts'].map((x) => UserPost.fromJson(x))),
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        following: List<dynamic>.from(json["following"].map((x) => x)),
        role: json["role"],
        accountStatus: json["accountStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        expiresAt: json["expiresAt"],
        token: json["token"],
        isVerified: json["isVerified"],
        resetPasswordToken: json["resetPasswordToken"],
        resetPasswordExpire: json["resetPasswordExpire"],
        lastActive: json["lastActive"] == null
            ? null
            : DateTime.parse(json["lastActive"]),
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar!.toJson(),
        "_id": id,
        "fname": fname,
        "lname": lname,
        "email": email,
        "uname": uname,
        "phone": phone!.toJson(),
        "gender": gender,
        "dob": dob,
        "about": about,
        "posts": List<dynamic>.from(posts.map((x) => x)),
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x)),
        "role": role,
        "accountStatus": accountStatus,
        "createdAt": createdAt.toIso8601String(),
        "expiresAt": expiresAt,
        "token": token,
        "isVerified": isVerified,
        "resetPasswordToken": resetPasswordToken,
        "resetPasswordExpire": resetPasswordExpire,
        "lastActive": lastActive!.toIso8601String(),
      };
}

class UserPost {
  UserPost({
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
  final String? owner;
  final List<dynamic>? likes;
  final List<dynamic>? comments;
  final String? postStatus;
  final DateTime? createdAt;

  factory UserPost.fromRawJson(String str) =>
      UserPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserPost.fromJson(Map<String, dynamic> json) => UserPost(
        id: json["_id"],
        caption: json["caption"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        owner: json["owner"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        postStatus: json["postStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "caption": caption,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "owner": owner,
        "likes": List<dynamic>.from(likes!.map((x) => x)),
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "postStatus": postStatus,
        "createdAt": createdAt!.toIso8601String(),
      };
}

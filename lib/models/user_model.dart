import 'dart:convert';

import 'package:social_media_app/models/post_model.dart';

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
  final List<PostModel> posts;
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
        posts: List<PostModel>.from(
            json['posts'].map((x) => PostModel.fromJson(x))),
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

class Avatar {
  Avatar({
    required this.publicId,
    required this.url,
  });

  final String publicId;
  final String url;

  factory Avatar.fromRawJson(String str) => Avatar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        publicId: json["public_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "public_id": publicId,
        "url": url,
      };
}

class Phone {
  Phone({
    this.countryCode,
    this.phoneNo,
  });

  final String? countryCode;
  final String? phoneNo;

  factory Phone.fromRawJson(String str) => Phone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        countryCode: json["countryCode"],
        phoneNo: json["phoneNo"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "phoneNo": phoneNo,
      };
}

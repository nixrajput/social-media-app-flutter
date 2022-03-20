import 'dart:convert';

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
    this.avatar,
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.uname,
    this.posts,
    this.followers,
    this.following,
    this.role,
    this.accountStatus,
    this.createdAt,
    this.v,
    this.expiresAt,
    this.token,
    this.isVerified,
  });

  final Avatar? avatar;
  final String? id;
  final String? fname;
  final String? lname;
  final String? email;
  final String? uname;
  final List<dynamic>? posts;
  final List<dynamic>? followers;
  final List<dynamic>? following;
  final String? role;
  final String? accountStatus;
  final DateTime? createdAt;
  final int? v;
  final String? expiresAt;
  final String? token;
  final bool? isVerified;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
        id: json["_id"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        uname: json["uname"],
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        following: List<dynamic>.from(json["following"].map((x) => x)),
        role: json["role"],
        accountStatus: json["accountStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        expiresAt: json["expiresAt"],
        token: json["token"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar!.toJson(),
        "_id": id,
        "fname": fname,
        "lname": lname,
        "email": email,
        "uname": uname,
        "posts": List<dynamic>.from(posts!.map((x) => x)),
        "followers": List<dynamic>.from(followers!.map((x) => x)),
        "following": List<dynamic>.from(following!.map((x) => x)),
        "role": role,
        "accountStatus": accountStatus,
        "createdAt": createdAt!.toIso8601String(),
        "__v": v,
        "expiresAt": expiresAt,
        "token": token,
        "isVerified": isVerified,
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

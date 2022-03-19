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
        "user": user?.toJson(),
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
    required this.userIsVerified,
    required this.createdAt,
    required this.v,
    required this.expiresAt,
    required this.token,
    required this.isVerified,
  });

  final String id;
  final String fname;
  final String lname;
  final String email;
  final String uname;
  final List<dynamic> posts;
  final List<dynamic> followers;
  final List<dynamic> following;
  final String role;
  final String accountStatus;
  final bool userIsVerified;
  final DateTime createdAt;
  final int v;
  final String expiresAt;
  final String token;
  final bool isVerified;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        userIsVerified: json["is_verified"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        expiresAt: json["expiresAt"],
        token: json["token"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fname": fname,
        "lname": lname,
        "email": email,
        "uname": uname,
        "posts": List<dynamic>.from(posts.map((x) => x)),
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x)),
        "role": role,
        "accountStatus": accountStatus,
        "is_verified": userIsVerified,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "expiresAt": expiresAt,
        "token": token,
        "isVerified": isVerified,
      };
}

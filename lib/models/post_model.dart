import 'dart:convert';

class PostModel {
  PostModel({
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

  factory PostModel.fromRawJson(String str) =>
      PostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
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

class Image {
  Image({
    required this.publicId,
    required this.url,
    required this.id,
  });

  final String publicId;
  final String url;
  final String id;

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        publicId: json["public_id"],
        url: json["url"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "public_id": publicId,
        "url": url,
        "_id": id,
      };
}

import 'dart:convert';

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

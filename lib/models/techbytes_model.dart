import 'dart:convert';

class Techbytes {
  Techbytes({
    this.id,
    this.title,
    this.image,
    this.body,
    this.pubDate,
  });

  final int id;
  final String title;
  final String image;
  final String body;
  final DateTime pubDate;

  factory Techbytes.fromRawJson(String str) =>
      Techbytes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Techbytes.fromJson(Map<String, dynamic> json) => Techbytes(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        body: json["body"],
        pubDate: DateTime.parse(json["pub_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "body": body,
        "pub_date": pubDate.toIso8601String(),
      };
}

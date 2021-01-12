import 'dart:convert';

class DevTo {
  DevTo({
    this.typeOf,
    this.id,
    this.title,
    this.description,
    this.coverImage,
    this.published,
    this.publishedAt,
    this.tagList,
    this.slug,
    this.path,
    this.url,
    this.canonicalUrl,
    this.commentsCount,
    this.positiveReactionsCount,
    this.publicReactionsCount,
    this.pageViewsCount,
    this.publishedTimestamp,
    this.bodyMarkdown,
    this.user,
    this.organization,
    this.flareTag,
  });

  final String typeOf;
  final int id;
  final String title;
  final String description;
  final String coverImage;
  final bool published;
  final DateTime publishedAt;
  final List<String> tagList;
  final String slug;
  final String path;
  final String url;
  final String canonicalUrl;
  final int commentsCount;
  final int positiveReactionsCount;
  final int publicReactionsCount;
  final int pageViewsCount;
  final DateTime publishedTimestamp;
  final String bodyMarkdown;
  final User user;
  final Organization organization;
  final FlareTag flareTag;

  factory DevTo.fromRawJson(String str) => DevTo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DevTo.fromJson(Map<String, dynamic> json) => DevTo(
        typeOf: json["type_of"],
        id: json["id"],
        title: json["title"],
        description: json["description"],
        coverImage: json["cover_image"],
        published: json["published"],
        publishedAt: DateTime.parse(json["published_at"]),
        tagList: List<String>.from(json["tag_list"].map((x) => x)),
        slug: json["slug"],
        path: json["path"],
        url: json["url"],
        canonicalUrl: json["canonical_url"],
        commentsCount: json["comments_count"],
        positiveReactionsCount: json["positive_reactions_count"],
        publicReactionsCount: json["public_reactions_count"],
        pageViewsCount: json["page_views_count"],
        publishedTimestamp: DateTime.parse(json["published_timestamp"]),
        bodyMarkdown: json["body_markdown"],
        user: User.fromJson(json["user"]),
        organization: Organization.fromJson(json["organization"]),
        flareTag: FlareTag.fromJson(json["flare_tag"]),
      );

  Map<String, dynamic> toJson() => {
        "type_of": typeOf,
        "id": id,
        "title": title,
        "description": description,
        "cover_image": coverImage,
        "published": published,
        "published_at": publishedAt.toIso8601String(),
        "tag_list": List<dynamic>.from(tagList.map((x) => x)),
        "slug": slug,
        "path": path,
        "url": url,
        "canonical_url": canonicalUrl,
        "comments_count": commentsCount,
        "positive_reactions_count": positiveReactionsCount,
        "public_reactions_count": publicReactionsCount,
        "page_views_count": pageViewsCount,
        "published_timestamp": publishedTimestamp.toIso8601String(),
        "body_markdown": bodyMarkdown,
        "user": user.toJson(),
        "organization": organization.toJson(),
        "flare_tag": flareTag.toJson(),
      };
}

class FlareTag {
  FlareTag({
    this.name,
    this.bgColorHex,
    this.textColorHex,
  });

  final String name;
  final String bgColorHex;
  final String textColorHex;

  factory FlareTag.fromRawJson(String str) =>
      FlareTag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlareTag.fromJson(Map<String, dynamic> json) => FlareTag(
        name: json["name"],
        bgColorHex: json["bg_color_hex"],
        textColorHex: json["text_color_hex"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "bg_color_hex": bgColorHex,
        "text_color_hex": textColorHex,
      };
}

class Organization {
  Organization({
    this.name,
    this.username,
    this.slug,
    this.profileImage,
    this.profileImage90,
  });

  final String name;
  final String username;
  final String slug;
  final String profileImage;
  final String profileImage90;

  factory Organization.fromRawJson(String str) =>
      Organization.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        name: json["name"],
        username: json["username"],
        slug: json["slug"],
        profileImage: json["profile_image"],
        profileImage90: json["profile_image_90"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "slug": slug,
        "profile_image": profileImage,
        "profile_image_90": profileImage90,
      };
}

class User {
  User({
    this.name,
    this.username,
    this.twitterUsername,
    this.githubUsername,
    this.websiteUrl,
    this.profileImage,
    this.profileImage90,
  });

  final String name;
  final String username;
  final String twitterUsername;
  final String githubUsername;
  final String websiteUrl;
  final String profileImage;
  final String profileImage90;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        username: json["username"],
        twitterUsername: json["twitter_username"],
        githubUsername: json["github_username"],
        websiteUrl: json["website_url"],
        profileImage: json["profile_image"],
        profileImage90: json["profile_image_90"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "twitter_username": twitterUsername,
        "github_username": githubUsername,
        "website_url": websiteUrl,
        "profile_image": profileImage,
        "profile_image_90": profileImage90,
      };
}

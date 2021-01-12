import 'dart:convert';

class DevTo {
  DevTo({
    this.typeOf,
    this.id,
    this.title,
    this.description,
    this.coverImage,
    this.readablePublishDate,
    this.socialImage,
    this.tagList,
    this.tags,
    this.slug,
    this.path,
    this.url,
    this.canonicalUrl,
    this.commentsCount,
    this.positiveReactionsCount,
    this.publicReactionsCount,
    this.collectionId,
    this.createdAt,
    this.editedAt,
    this.crosspostedAt,
    this.publishedAt,
    this.lastCommentAt,
    this.publishedTimestamp,
    this.user,
    this.organization,
  });

  final String typeOf;
  final int id;
  final String title;
  final String description;
  final String coverImage;
  final String readablePublishDate;
  final String socialImage;
  final List<String> tagList;
  final String tags;
  final String slug;
  final String path;
  final String url;
  final String canonicalUrl;
  final int commentsCount;
  final int positiveReactionsCount;
  final int publicReactionsCount;
  final dynamic collectionId;
  final DateTime createdAt;
  final DateTime editedAt;
  final dynamic crosspostedAt;
  final DateTime publishedAt;
  final DateTime lastCommentAt;
  final DateTime publishedTimestamp;
  final User user;
  final Organization organization;

  factory DevTo.fromRawJson(String str) => DevTo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DevTo.fromJson(Map<String, dynamic> json) => DevTo(
        typeOf: json["type_of"],
        id: json["id"],
        title: json["title"],
        description: json["description"],
        coverImage: json["cover_image"],
        readablePublishDate: json["readable_publish_date"],
        socialImage: json["social_image"],
        tagList: List<String>.from(json["tag_list"].map((x) => x)),
        tags: json["tags"],
        slug: json["slug"],
        path: json["path"],
        url: json["url"],
        canonicalUrl: json["canonical_url"],
        commentsCount: json["comments_count"],
        positiveReactionsCount: json["positive_reactions_count"],
        publicReactionsCount: json["public_reactions_count"],
        collectionId: json["collection_id"],
        createdAt: DateTime.parse(json["created_at"]),
        editedAt: DateTime.parse(json["edited_at"]),
        crosspostedAt: json["crossposted_at"],
        publishedAt: DateTime.parse(json["published_at"]),
        lastCommentAt: DateTime.parse(json["last_comment_at"]),
        publishedTimestamp: DateTime.parse(json["published_timestamp"]),
        user: User.fromJson(json["user"]),
        organization: Organization.fromJson(json["organization"]),
      );

  Map<String, dynamic> toJson() => {
        "type_of": typeOf,
        "id": id,
        "title": title,
        "description": description,
        "cover_image": coverImage,
        "readable_publish_date": readablePublishDate,
        "social_image": socialImage,
        "tag_list": List<dynamic>.from(tagList.map((x) => x)),
        "tags": tags,
        "slug": slug,
        "path": path,
        "url": url,
        "canonical_url": canonicalUrl,
        "comments_count": commentsCount,
        "positive_reactions_count": positiveReactionsCount,
        "public_reactions_count": publicReactionsCount,
        "collection_id": collectionId,
        "created_at": createdAt.toIso8601String(),
        "edited_at": editedAt.toIso8601String(),
        "crossposted_at": crosspostedAt,
        "published_at": publishedAt.toIso8601String(),
        "last_comment_at": lastCommentAt.toIso8601String(),
        "published_timestamp": publishedTimestamp.toIso8601String(),
        "user": user.toJson(),
        "organization": organization.toJson(),
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

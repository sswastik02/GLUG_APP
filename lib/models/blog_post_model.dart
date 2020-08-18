import 'package:glug_app/resources/database_provider.dart';

class BlogPost {
  final bool show_bool;
  final int id;
  final String title;
  final String author_name;
  final String thumbnail_image;
  final String content_body;
  final String date_to_show;
  final List comments;

  BlogPost(
      this.show_bool,
      this.id,
      this.title,
      this.author_name,
      this.thumbnail_image,
      this.content_body,
      this.date_to_show,
      this.comments);

  BlogPost.fromJSON(Map<String, dynamic> jsonMap)
      : show_bool = (jsonMap['show_bool'] == 1 || jsonMap['show_bool']) == true
            ? true
            : false,
        id = jsonMap['id'],
        title = jsonMap['title'],
        author_name = jsonMap['author_name'],
        thumbnail_image = jsonMap['thumbnail_image'],
        content_body = jsonMap['content_body'],
        date_to_show = jsonMap['date_to_show'],
        comments = null;

  Map<String, dynamic> toMap() => {
        DatabaseProvider.BLOG_SHOW: show_bool ? 1 : 0,
        DatabaseProvider.BLOG_ID: id,
        DatabaseProvider.BLOG_TITLE: title,
        DatabaseProvider.BLOG_AUTHOR: author_name,
        DatabaseProvider.BLOG_IMAGE: thumbnail_image,
        DatabaseProvider.BLOG_CONTENT: content_body,
        DatabaseProvider.BLOG_DATE: date_to_show,
        DatabaseProvider.BLOG_COMMENTS: "",
      };
}

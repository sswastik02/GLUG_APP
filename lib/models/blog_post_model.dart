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
      : show_bool = jsonMap['show_bool'],
        id = jsonMap['id'],
        title = jsonMap['title'],
        author_name = jsonMap['author_name'],
        thumbnail_image = jsonMap['thumbnail_image'],
        content_body = jsonMap['content_body'],
        date_to_show = jsonMap['date_to_show'],
        comments = jsonMap['comments'];
}

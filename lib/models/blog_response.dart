import 'package:glug_app/models/blog_post_model.dart';

class BlogResponse {
  final List<BlogPost> blogPosts;
  final String error;

  BlogResponse.fromJSON(List<dynamic> json)
      : blogPosts = json.map((data) => BlogPost.fromJSON(data)).toList(),
        error = "";

  BlogResponse.withError(String errorVal)
      : blogPosts = List(),
        error = errorVal;
}

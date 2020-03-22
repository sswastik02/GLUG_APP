import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:glug_app/models/blog_post_model.dart';

Future<Stream<BlogPost>> getBlogPosts() async {
  final String url = 'https://api.nitdgplug.org/blog/posts/';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => BlogPost.fromJSON(data));
}

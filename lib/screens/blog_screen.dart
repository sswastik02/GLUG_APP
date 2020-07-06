import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glug_app/blocs/blogPosts_bloc.dart';
import 'package:glug_app/models/blog_post_model.dart';
import 'package:glug_app/models/blog_response.dart';
import 'package:glug_app/widgets/blog_post_tile.dart';
import 'package:glug_app/widgets/error_widget.dart';

class BlogScreen extends StatefulWidget {
  static final id = 'blogscreen';

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    blogPostsBloc.fetchAllBlogPosts();
    super.initState();
  }

  @override
  void dispose() {
    blogPostsBloc.dispose();
    super.dispose();
  }

  List<BlogPost> _sort(List<BlogPost> e) {
    e.sort((a, b) => DateTime.parse(a.date_to_show)
        .toLocal()
        .compareTo(DateTime.parse(b.date_to_show).toLocal()));
    return e;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Blog",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              FaIcon(FontAwesomeIcons.blog),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          color: Theme.of(context).primaryColor,
        ),
        Expanded(
          child: StreamBuilder(
            stream: blogPostsBloc.allBlogPosts,
            builder: (context, AsyncSnapshot<BlogResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return errorWidget(snapshot.data.error);
                }
                List<BlogPost> posts = _sort(snapshot.data.blogPosts);
                posts = posts.reversed.toList();

                return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return BlogPostTile(post: posts[index]);
                    });
              } else if (snapshot.hasError) {
                return errorWidget(snapshot.error);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:glug_app/database/blog_post_database.dart';
import 'package:glug_app/models/blog_post_model.dart';
import 'package:glug_app/widgets/drawer_contents.dart';
import 'package:glug_app/widgets/blog_post_tile.dart';

class BlogScreen extends StatefulWidget {
  static final id = 'blogscreen';

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

// Unable to use FutureBuilder because of screen flickering.

class _BlogScreenState extends State<BlogScreen> {
  List<BlogPost> _blogs = [];

  @override
  void initState() {
    super.initState();
    listenForBlogs();
  }

  void listenForBlogs() async {
    final Stream<BlogPost> stream = await getBlogPosts();
    stream.listen((BlogPost post) => setState(() => _blogs.add(post)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BLOG",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/drawer_header.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: DrawerContents(3),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 5.0,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('images/glug_logo.jpeg'),
                ),
                title: Text(
                  "Developed by the GNU Linux Users' Group NITDGP",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _blogs.length,
              itemBuilder: (context, index) {
                return BlogPostTile(
                  post: _blogs.reversed.toList()[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

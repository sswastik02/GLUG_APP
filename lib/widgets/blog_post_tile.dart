import 'package:date_format/date_format.dart';
import 'package:glug_app/models/blog_post_model.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/screens/blog.dart';
import 'package:html/parser.dart';

class BlogPostTile extends StatelessWidget {
  final BlogPost post;

  BlogPostTile({this.post});

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  String _getDate(String s) {
    DateTime dateTime = DateTime.parse(s).toLocal();
    var date = formatDate(dateTime, [dd, '/', mm, '/', yyyy]);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return post.thumbnail_image != null
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(
                      height: 250.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: post.thumbnail_image != null
                            ? NetworkImage(post.thumbnail_image)
                            : AssetImage('images/glug_logo.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 0.0,
                    ),
                    child: Center(
                      child: Text(
                        post.title,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        _getDate(post.date_to_show),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.edit),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        post.author_name,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
//                  Padding(
//                    padding: EdgeInsets.symmetric(
//                      vertical: 10.0,
//                      horizontal: 10.0,
//                    ),
//                    child: Text(
//                      _parseHtmlString(post.content_body),
//                      style: TextStyle(
//                        color: Colors.grey,
//                      ),
//                      overflow: TextOverflow.ellipsis,
//                    ),
//                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 30.0,
                    ),
                    child: RaisedButton(
                      elevation: 5.0,
                      color: Colors.deepOrangeAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Blog(post: post),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Read',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }
}

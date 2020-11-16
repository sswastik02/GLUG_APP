import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:glug_app/models/blog_post_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Blog extends StatelessWidget {
  static final id = 'blog';

  final BlogPost post;

  Blog({this.post});

  String _getDate(String s) {
    DateTime dateTime = DateTime.parse(s).toLocal();
    var date = formatDate(dateTime, [dd, '/', mm, '/', yyyy]);
    return date;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(

            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(post.thumbnail_image),
                fit: BoxFit.cover,
              ),
            ),
            child:Container(

              margin: EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  new IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    color: Colors.white,
                  ),
                ],
              ),
            )

          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.75,
            builder: (context, _scrollController) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
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
                      height: 20.0,
                    ),
                    Html(
                      data: post.content_body,
                      //Optional parameters:
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),

                      defaultTextStyle: TextStyle(
                        fontFamily: "Montserrat",
                      ),
                      linkStyle: const TextStyle(
                        color: Colors.blueAccent,
                      ),
                      useRichText: false,
                      onLinkTap: (url) {
                        print("Opening $url");
                        _launchURL(url);
                      },
                      onImageTap: (src) {
                        // Display the image in large form.
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

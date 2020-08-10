import 'package:flutter/material.dart';
import 'package:glug_app/blocs/blogPosts_bloc.dart';
import 'package:glug_app/blocs/events_bloc.dart';
// import 'package:glug_app/blocs/home_bloc.dart';
import 'package:glug_app/models/blog_post_model.dart';
import 'package:glug_app/models/blog_response.dart';
// import 'package:glug_app/models/carousel_response.dart';
import 'package:glug_app/models/event_model.dart';
import 'package:glug_app/models/event_response.dart';
import 'package:glug_app/screens/blog.dart';
import 'package:glug_app/screens/event_info.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  static final id = 'homescreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // homeBloc.fetchAllData();
    eventsBloc.fetchAllEvents();
    blogPostsBloc.fetchAllBlogPosts();
    super.initState();
  }

  @override
  void dispose() {
    // homeBloc.dispose();
    eventsBloc.dispose();
    blogPostsBloc.dispose();
    super.dispose();
  }

  _buildEventList(List<Event> events) {
    events.removeWhere((event) => event.title == null);
    List<Widget> eventWidgets = events
        .map(
          (item) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventInfo(event: item),
                  ));
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: item.event_image != null
                      ? NetworkImage(item.event_image)
                      : AssetImage("images/glug_logo.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(225, 255, 255, 255),
                ),
              ),
            ),
          ),
        )
        .toList();

    return eventWidgets;
  }

  _buildBlogList(List<BlogPost> blogs) {
    blogs.removeWhere((blog) => blog.title == null);
    List<Widget> blogWidgets = blogs
        .map(
          (item) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Blog(post: item),
                  ));
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: item.thumbnail_image != null
                      ? NetworkImage(item.thumbnail_image)
                      : AssetImage("images/glug_logo.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(225, 255, 255, 255),
                ),
              ),
            ),
          ),
        )
        .toList();

    return blogWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HOME"
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           /* Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("images/glug_logo.jpeg"),
                    radius: 20.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "HOME",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
              color: Theme.of(context).primaryColor,
            ),*/
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "OU",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                      Text(
                        "R EV",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Colors.deepOrange
                        ),
                      ),

                      Text(
                        "ENTS",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,

                        ),
                      ),

                    ]
                  )
              ),
            ),
            StreamBuilder(
                stream: eventsBloc.allEvents,
                builder: (context, AsyncSnapshot<EventResponse> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.error != null &&
                        snapshot.data.error.length > 0)
                      return errorWidget(snapshot.data.error);
                    return CarouselSlider(
                      items: _buildEventList(snapshot.data.events),
                      options: CarouselOptions(
                        aspectRatio: 2,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return errorWidget(snapshot.error);
                  } else
                    return Center(child: CircularProgressIndicator());
                }),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "OU",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                    Text(
                      "R BL",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.deepOrange
                      ),
                    ),

                    Text(
                      "OGS",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,

                      ),
                    ),

                  ]
              )
              ),
            ),
            StreamBuilder(
                stream: blogPostsBloc.allBlogPosts,
                builder: (context, AsyncSnapshot<BlogResponse> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.error != null &&
                        snapshot.data.error.length > 0)
                      return errorWidget(snapshot.data.error);
                    return CarouselSlider(
                      items: _buildBlogList(snapshot.data.blogPosts),
                      options: CarouselOptions(
                        aspectRatio: 2,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return errorWidget(snapshot.error);
                  } else
                    return Center(child: CircularProgressIndicator());
                }),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      )
      ,

    );
  }
}

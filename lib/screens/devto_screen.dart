import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/blocs/devto_bloc.dart';
import 'package:glug_app/models/devto_model.dart';
import 'package:glug_app/models/devto_response.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DevToScreen extends StatefulWidget {
  @override
  _DevToScreen createState() => _DevToScreen();
}

class _DevToScreen extends State<DevToScreen> {
  List<DevTo> postList;

  @override
  void initState() {
    devToBloc.fetchDevArticles();
    super.initState();
  }

  @override
  void dispose() {
    devToBloc.dispose();
    super.dispose();
  }

  _launchURL(String str) async {
    if (await canLaunch(str)) {
      await launch(str);
    } else {
      throw 'Could not launch $str';
    }
  }
  _buildDevList(List<DevTo> posts) {
    posts.removeWhere((post) => post.title == null);
    List<Widget> postWidgets = posts.map((item) {
      //var random = getRandString(10);
      print(item.coverImage);
      return GestureDetector(
          onTap: () {
            _launchURL(item.url);
          },
          child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: item.coverImage != null
                          ? CachedNetworkImageProvider(item.coverImage)
                          : AssetImage('images/glug_logo.jpeg'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ])));
    }).toList();

    return postWidgets;
  }

  _buildEventList(List<DevTo> events) {
    events.removeWhere((event) => event.title == null);
    /*events.removeWhere((event) => DateTime.parse(event.event_timing)
        .toLocal()
        .isBefore(DateTime(DateTime.now().year - 1, 1, 1).toLocal()));*/
    List<Widget> eventWidgets = events.map((item) {
      //var random = getRandString(10);
      print(events.length);
      return Padding(padding:EdgeInsets.all(10), child : GestureDetector(
          onTap: () {
            _launchURL(item.url);
          },
          child: Stack(children: [
            //Hero(tag: random, child:
            Container(
              height: 150,
             alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: item.coverImage != null
                      ? CachedNetworkImageProvider(
                    item.coverImage,
                  )
                      : AssetImage("images/glug_logo.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // ),

            /*Image(
              image: item.coverImage != null
                  ? CachedNetworkImageProvider(item.coverImage)
                  : AssetImage('images/glug_logo.jpeg'),
            ),*/

            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin:  EdgeInsets.only(top: 100),
                height: 50.0,
                child: Center(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ])));
    }).toList();

    return eventWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'DEV Posts',
                        style: TextStyle(
                            fontFamily: "Nexa-Bold",
                            fontSize: MediaQuery.of(context).size.width * 0.052,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ]),
          ),

          StreamBuilder(
              stream: devToBloc.alldevArticles,
              builder: (context, AsyncSnapshot<DevToResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return errorWidget(snapshot.data.error);
                  }
                  return Expanded(
                      child: ListView(
                    children: _buildEventList(snapshot.data.articles),
                  ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ])));
  }
}

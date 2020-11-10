//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/screens/firebase_messaging_demo_screen.dart';
import 'package:glug_app/services/auth_service.dart';
import 'package:glug_app/widgets/drawer_items.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:glug_app/widgets/message_tile.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import 'login_screen.dart';

class Chatroom extends StatefulWidget {
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  FirestoreProvider _provider;
  var userEmail = "";

  @override
  void initState() {
    _provider = FirestoreProvider();
    _initEmail();
    super.initState();
  }

  void _initEmail() async {
    var ins = await _provider.getCurrentUserEmail();
    setState(() {
      userEmail = ins;
      print(userEmail);
    });
  }

  @override
  void dispose() {
    _provider = null;
    super.dispose();
  }

  _buildChats(List<dynamic> chats) {
    List<Widget> tiles = chats.map((chat) {
      /*return ListTile(
        onTap: () {},
        leading: CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(chat["photoUrl"]),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              chat["sender"],
              style: TextStyle(
                  fontFamily: "Montserrat", fontWeight: FontWeight.bold),
            ),
            Text(
              timeago.format(chat["time"].toDate()),
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
          ],
        ),
        subtitle: Linkify(
          onOpen: (link) async {
            if (await canLaunch(link.url)) {
              await launch(link.url);
            } else {
              throw 'Could not launch $link';
            }
          },
          text: chat["message"],
          style: TextStyle(color: Colors.black54),
          linkStyle: TextStyle(color: Colors.blue),
        ),
      );*/

      bool isSentByMe;
      if (chat["email"] == userEmail) {
        isSentByMe = true;
      } else {
        isSentByMe = false;
      }
      return MessageTile(
          message: chat["message"],
          sender: chat["sender"],
          sentByMe: isSentByMe,
          timeAGo: timeago.format(chat["time"].toDate()));
    }).toList();

    return tiles;
  }

  _buildChatComposer() {
    TextEditingController _controller = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFDD0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 50.0,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              cursorColor: Theme.of(context).primaryColor,
              textCapitalization: TextCapitalization.sentences,
              controller: _controller,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (_controller.text.toString().length == 0) return;
              FocusScope.of(context).unfocus();
              _provider.composeMessage(_controller.text.toString());
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Room"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Feel free to ask questions on Open Source Technology'),
                  duration: Duration(seconds: 3),
                ));
              }),
        ],
      ),
      drawer: Drawer(
        child: DrawerItems(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder(
            stream: _provider.fetchChatroomData(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  reverse: true,
                  children: _buildChats(snapshot.data.documents),
                );
              } else if (snapshot.hasError)
                return errorWidget(snapshot.error);
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: userEmail != null && userEmail.length != 0
                ? _buildChatComposer()
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Sign in with a social account to chat",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            signOutGuest().whenComplete(() {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                                  return LoginScreen();
                                }),
                              );
                            });
                          },
                          child: Text(
                            "Sign out",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Colors.deepOrangeAccent,
                        )
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

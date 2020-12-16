import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/widgets/drawer_items.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:glug_app/widgets/message_tile.dart';
import 'package:timeago/timeago.dart' as timeago;

class Chatroom extends StatefulWidget {
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  FirestoreProvider _provider;
  var _userEmail = "";
  var _isAdmin = false;

  @override
  void initState() {
    _provider = FirestoreProvider();
    _initEmail();
    _initAdmin();
    super.initState();
  }

  void _initEmail() async {
    var ins = await _provider.getCurrentUserEmail();
    setState(() {
      _userEmail = ins;
      print(_userEmail);
    });
  }

  void _initAdmin() async {
    var res = await _provider.isAdmin();
    setState(() {
      _isAdmin = res;
    });
  }

  @override
  void dispose() {
    _provider = null;
    super.dispose();
  }

  _buildChats(List<dynamic> chats) {
    List<Widget> tiles = chats.map((chat) {
      bool isSentByMe;
      if (chat["email"] == _userEmail) {
        isSentByMe = true;
      } else {
        isSentByMe = false;
      }
      return GestureDetector(
        onLongPress: () {
          if (_isAdmin) {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Options",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Text("What would you like to do?"),
                    actions: [
                      FlatButton(
                        color: Colors.deepOrangeAccent,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      FlatButton(
                        color: Colors.deepOrangeAccent,
                        onPressed: () {
                          _provider.deleteMessage(chat.documentID);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "DELETE",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                });
          }
        },
        child: MessageTile(
            message: chat["message"],
            sender: chat["sender"],
            sentByMe: isSentByMe,
            timeAGo: timeago.format(chat["time"].toDate())),
      );
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
                  children: _buildChats(snapshot.data.docs),
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
            child: _buildChatComposer(),
          ),
        ],
      ),
    );
  }
}

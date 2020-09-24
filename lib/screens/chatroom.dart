import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/widgets/drawer_items.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class Chatroom extends StatefulWidget {
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  FirestoreProvider _provider;

  @override
  void initState() {
    _provider = FirestoreProvider();
    super.initState();
  }

  @override
  void dispose() {
    _provider = null;
    super.dispose();
  }

  _buildChats(List<dynamic> chats) {
    List<Widget> tiles = chats.map((chat) {
      DocumentReference userRef = chat["user"];
      return ListTile(
        onTap: () {},
        leading: CircleAvatar(
          radius: 20.0,
          //backgroundImage: NetworkImage(docSnapshot.data["photoUrl"]),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
                   "name",
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
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
        subtitle: Text(
          chat["message"],
          style: TextStyle(fontFamily: "Montserrat"),
        ),
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
        title: Text(
          "Chat Room"
        ),
        actions:<Widget> [
          IconButton (
            icon:Icon (Icons.info),
            onPressed: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Feel free to ask questions on Open Source Technology'),
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
         /* SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "NITDGP OS",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Icon(Icons.chat),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              '"Feel free to ask questions on Open Source Technology"',
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Theme.of(context).primaryColor,
          ),*/
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
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: _buildChatComposer(),
          ),
        ],
      ),

    );

  }
}

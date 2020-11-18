import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String sender;
  final String timeAGo;
  final bool sentByMe;

  MessageTile({this.message, this.sender, this.sentByMe, this.timeAGo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4, bottom: 4, left: sentByMe ? 0 : 24, right: sentByMe ? 24 : 0),
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sentByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: sentByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10))
              : BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
          color: sentByMe
              ? /*Color.fromRGBO(227, 125, 52, .9)*/ Colors.deepOrangeAccent
              : Color.fromRGBO(196, 105, 41, .9), //179, 86, 52
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sentByMe
                ? SizedBox()
                : Text(sender,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: Colors.black,
                        letterSpacing: -0.5)),
            SizedBox(height: sentByMe ? 0 : 3.0),
            Linkify(
              onOpen: (link) async {
                if (await canLaunch(link.url)) {
                  await launch(link.url);
                } else {
                  throw 'Could not launch $link';
                }
              },
              text: message,
              style: TextStyle(fontSize: 15.0, color: Colors.white),
              linkStyle: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 2),
            Text(timeAGo,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 10.0, color: Colors.black, letterSpacing: -0.5)),
          ],
        ),
      ),
    );
  }
}

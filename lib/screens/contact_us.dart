import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _tile(String name, String number, String email) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
          elevation: 8,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL("tel:$number");
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: Colors.deepOrangeAccent,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(number)
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL("mailto:$email");
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: Colors.deepOrangeAccent,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(email)
                    ],
                  ),
                )
              ],
            ),
          )),
    );
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
                  'Contact Us',
                  style: TextStyle(
                    fontFamily: "Nexa-Bold",
                    fontSize: MediaQuery.of(context).size.width * 0.052,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _tile("Liman Rahman (President)", "+91 9475522304",
                  "president@nitdgplug.org"),
              _tile("Akshat Jain (General Secretary)", "+91 8004937056",
                  "gs@nitdgplug.org"),
              _tile("Ayush Shukla (Treasurer)", "+91 8001507060",
                  "treasurer@nitdgplug.org"),
              _tile("Archana Choudhary (Convener)", "+91 7044791608",
                  "convenor@nitdgplug.org"),
            ],
          ))
        ])));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/widgets/drawer_items.dart';

class AboutUS extends StatelessWidget {
  Widget _getTitle(String m) {
    Widget txt1 = Text(
      m.substring(0, 3),
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
    Widget txt2 = Text(
      m.substring(3, 5),
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrange,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
    Widget txt3 = Text(
      m.substring(5),
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrange,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );

    return Row(
      children: <Widget>[
        txt1,
        txt2,
        txt3,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        drawer: Drawer(
          child: DrawerItems(),
        ),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                  'About Us',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(15),
              children: <Widget>[
                _getTitle("WHO WE ARE"),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Established in 2003 The GNU/Linux Users Group, NIT Durgapur is a community of GNU/Linux Users that promote the use of Free and Open Source Software. We are a team of designers, developers and contributors that believe in learning and sharing through opening up your mind to Open Source.",
                ),
                SizedBox(
                  height: 20,
                ),
                _getTitle("WHAT WE DO"),
                SizedBox(
                  height: 5,
                ),
                Text(
                    "We provide budding enthusiasts like ourselves a forum to contribute and learn about FOSS. Through varied workshops on Open Source Technologies, we spread the idea of Open Source to novices and veterans alike. We extend help and resources to everyone who wants to make the web world a better place."),
                SizedBox(
                  height: 20,
                ),
                _getTitle("OUR VISION"),
                SizedBox(
                  height: 5,
                ),
                Text(
                    "Being a bunch of FOSS enthusiasts, we promote the idea of “free things are the best things”. We strive to elevate the tech culture in our college and believe that this can only be done by giving people digital resources and knowledge in all realms from hardware to software and data to design."),
              ],
            ),
          )
        ]));
  }
}

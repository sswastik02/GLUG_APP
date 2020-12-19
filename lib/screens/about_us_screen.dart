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
      drawer: Drawer(
        child: DrawerItems(),
      ),
      body:
      Column(
          children: [
      Padding(padding: EdgeInsets.fromLTRB(0, 30, 0,0),
      child:Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back,size: 30,),
              onPressed:(){
                Navigator.of(context).pop(true);
              }),
          SizedBox(width: 20,),
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
      Expanded(child:
      ListView(
        padding: EdgeInsets.all(15),
        children: <Widget>[
          _getTitle("WHO WE ARE"),
          SizedBox(
            height: 5,
          ),
          Text(
            "The GNU/Linux User’s Group, NIT Durgapur is a community of GNU/Linux Users that promote the use of Free and Open Source Software. The Group was established in 2003 by a bunch of FOSS enthusiasts with the idea of popularising and contributing to Open Source. We are a plethora of designers, contributors and developers that believe in learning and sharing through opening up your mind to Open Source.",
          ),
          SizedBox(
            height: 20,
          ),
          _getTitle("WHAT WE DO"),
          SizedBox(
            height: 5,
          ),
          Text(
              "We provide budding enthusiasts like ourselves a forum to contribute and learn about FOSS. Through varied workshops on revolutionary Open Technologies throughout the year, we spread the idea of Open Source to beginners and veterans alike. We bring people together to ideate and contribute to the leading Open technologies. We provide help and resources to everyone who wants to make the web world a better place."),
          SizedBox(
            height: 20,
          ),
          _getTitle("OUR VISION"),
          SizedBox(
            height: 5,
          ),
          Text(
              "Being a bunch of FOSS enthusiasts, we preach the idea of “free things are the best things” and firmly believe in sharing knowledge. We strive to elevate the tech culture in our college and believe that this can only be done through giving people digital resources and knowledge in all realms from hardware to software and data to design. We promote FOSS through various endeavours because we believe in the freedom of expression for everyone."),
        ],
      ),
      )
    ]
    )

    );
  }
}

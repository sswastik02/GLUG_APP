import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUS extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _getTitle(String m, context) {
    Widget txt1 = Text(
      m.substring(0, 3),
      style: TextStyle(
        fontFamily: "Nexa-Bold",
        fontSize: MediaQuery.of(context).size.height * 0.03,
        fontWeight: FontWeight.bold,
      ),
    );
    Widget txt2 = Text(
      m.substring(3, 5),
      style: TextStyle(
        fontFamily: "Nexa-Bold",
        fontSize: MediaQuery.of(context).size.height * 0.03,
        color: Colors.deepOrange,
        fontWeight: FontWeight.bold,
      ),
    );
    Widget txt3 = Text(
      m.substring(5),
      style: TextStyle(
        fontFamily: "Nexa-Bold",
        fontSize: MediaQuery.of(context).size.height * 0.03,
        color: Colors.deepOrange,
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
      body: SafeArea(
        child: Column(
          children: [
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
                    'About Us',
                    style: TextStyle(
                      fontFamily: "Nexa-Bold",
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(15),
                children: <Widget>[
                  _getTitle("WHO WE ARE", context),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Established in 2003 The GNU/Linux Users Group, NIT Durgapur is a community of GNU/Linux Users that promote the use of Free and Open Source Software. We are a team of designers, developers and contributors that believe in learning and sharing through opening up your mind to Open Source.",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _getTitle("WHAT WE DO", context),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "We provide budding enthusiasts like ourselves a forum to contribute and learn about FOSS. Through varied workshops on Open Source Technologies, we spread the idea of Open Source to novices and veterans alike. We extend help and resources to everyone who wants to make the web world a better place."),
                  SizedBox(
                    height: 20,
                  ),
                  _getTitle("OUR VISION", context),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Being a bunch of FOSS enthusiasts, we promote the idea of “free things are the best things”. We strive to elevate the tech culture in our college and believe that this can only be done by giving people digital resources and knowledge in all realms from hardware to software and data to design."),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.email,
                          size: 30.0,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _launchURL("mailto:contact@nitdgplug.org");
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.linkedin,
                          size: 30.0,
                          color: Colors.blue[900],
                        ),
                        onPressed: () {
                          _launchURL(
                              "https://in.linkedin.com/company/lugnitdgp");
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          _launchURL("https://www.facebook.com/nitdgplug");
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.instagram,
                          size: 30.0,
                          color: Colors.pink[800],
                        ),
                        onPressed: () {
                          _launchURL("https://www.instagram.com/nitdgplug");
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.youtube,
                          size: 30.0,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _launchURL(
                              "https://www.youtube.com/channel/UCYZPnN5vP5B1sINLLkI1aDA");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

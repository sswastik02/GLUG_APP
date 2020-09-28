import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glug_app/models/profile_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  final Profile profile;

  ProfilePage({this.profile});

  final List<String> yr = ['1st year', '2nd year', '3rd year', 'Final year'];

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _titleText() {
    String title = "";
    String former = '';

    if (profile.yearName > 4) {
      former = 'Former';
    }

    title += profile.position != null
        ? '$former ${profile.position}'
        : '$former Member';

    return title;
  }

  String _aboutText() {
    String about = "";
    about += profile.yearName <= 4 ? yr[profile.yearName - 1] : "Graduated";
    about += ", " + profile.degreeName + "\n\n";
    about += '~' + profile.bio;
    return about;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          profile.firstName + " " + profile.lastName,
          style: TextStyle(
            fontFamily: "Montserrat",
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage: profile.image != null
                      ? NetworkImage(profile.image)
                      : AssetImage('images/glug_logo.jpeg'),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              _titleText(),
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Text(
                _aboutText(),
                style: TextStyle(
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.facebookLink}");
                    _launchURL(profile.facebookLink);
                  },
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.github,
                    color: Colors.blueGrey,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.gitLink}");
                    _launchURL(profile.gitLink);
                  },
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.linkedin,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.linkedinLink}");
                    _launchURL(profile.linkedinLink);
                  },
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.reddit,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.redditLink}");
                    _launchURL(profile.redditLink);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.email,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.email}");
                    _launchURL("mailto:${profile.email}");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

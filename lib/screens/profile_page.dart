import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glug_app/models/profile_model.dart';
import 'package:glug_app/screens/webpage.dart';

class ProfilePage extends StatelessWidget {
  final Profile profile;

  ProfilePage({this.profile});

  final List<String> yr = [
    '1st year',
    '2nd year',
    '3rd year',
    'Final year',
    'Graduated'
  ];

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
    about += yr[profile.yearName - 1];
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
              child: Text(_aboutText()),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.facebookLink}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebPage(
                                  URL: profile.facebookLink,
                                )));
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.github,
                    color: Colors.blueGrey,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.gitLink}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebPage(
                                  URL: profile.gitLink,
                                )));
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.linkedin,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.linkedinLink}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebPage(
                                  URL: profile.linkedinLink,
                                )));
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.reddit,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.redditLink}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebPage(
                                  URL: profile.redditLink,
                                )));
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.email,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("Opening ${profile.email}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebPage(
                                  URL: profile.email,
                                )));
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

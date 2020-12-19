import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glug_app/models/profile_model.dart';
import 'package:glug_app/screens/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTile extends StatelessWidget {
  final Profile profile;
  bool isContributor=false;

  ProfileTile({this.profile, this.isContributor});

  final List<String> yr = ['1st year', '2nd year', '3rd year', 'Final year'];

  String _titleText() {
    String title = "";
    title += '${profile.firstName} ${profile.lastName} ';

    return title;
  }

  @override
  Widget build(BuildContext context) {
    var containerHeight= isContributor ? MediaQuery.of(context).size.height/3 : MediaQuery.of(context).size.height/4;
    var containerWidth= isContributor ? MediaQuery.of(context).size.width/1.5 : MediaQuery.of(context).size.width/2;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        // fit: StackFit.expand,
          children: <Widget>[
            Container(
              //color: Colors.black,
          height: containerHeight,
          width:containerWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: profile.image != null
                      ? NetworkImage(profile.image)
                      : AssetImage('images/glug_logo.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration:BoxDecoration(color: Colors.white,
                  shape: BoxShape.rectangle,
                  gradient: new LinearGradient(
                    colors: <Color>[
                      const Color.fromRGBO(255,255,255, 0.2),
                      const Color.fromRGBO(0,0,0, 0.7),
                    ],
                    stops: [0.2, 1.0],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                  )),
              height: containerHeight,
              width:containerWidth
            ),
            Container(
              height:80.0,
              width:containerWidth,
              margin: EdgeInsets.only(top: containerHeight- 80.0),
              color: Color.fromRGBO(0, 0, 0, 0.5),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child:Text(profile.firstName,
                      style: TextStyle(
                          fontSize: 18.0, color: Colors.white),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: IconButton(icon: Icon(FontAwesomeIcons.facebook),
                          disabledColor: Colors.black,
                          color: Colors.blueAccent,
                          onPressed: () {
                            _launchURL(profile.facebookLink);
                          },),
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.linkedin),
                        onPressed: () {
                          _launchURL(profile.linkedinLink);
                        },),
                      IconButton(icon: Icon(FontAwesomeIcons.github),
                        onPressed: () {
                         _launchURL(profile.gitLink);
                        },),
                    ],
                  ),
                ],
              ),
            )

          ]),
    );
  }

  _launchURL(String str) async {
    if (await canLaunch(str)) {
      await launch(str);
    } else {
      throw 'Could not launch $str';
    }
  }
}

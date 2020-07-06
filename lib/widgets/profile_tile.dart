import 'package:flutter/material.dart';
import 'package:glug_app/models/profile_model.dart';
import 'package:glug_app/screens/profile_page.dart';

class ProfileTile extends StatelessWidget {
  final Profile profile;

  ProfileTile({this.profile});

  final List<String> yr = ['1st year', '2nd year', '3rd year', 'Final year'];

  String _aboutText() {
    String about = "";
    about += profile.yearName <= 4 ? yr[profile.yearName - 1] : "Graduated";
    about += ", " + profile.degreeName + "\n";
    about += '~' + profile.bio;
    return about;
  }

  String _titleText() {
    String title = "";
    title += '${profile.firstName} ${profile.lastName} ';
    String former = '';

    if (profile.yearName > 4) {
      former = 'Former';
    }

    title += profile.position != null
        ? '($former ${profile.position} )'
        : '($former Member )';

    return title;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: profile.image != null
            ? NetworkImage(profile.image)
            : AssetImage('images/glug_logo.jpeg'),
      ),
      title: Text(
        _titleText(),
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        _aboutText(),
        style: TextStyle(
          fontFamily: "Montserrat",
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20.0,
      ),
      trailing: Text(
        profile.alias != null ? "@" + profile.alias : "",
        style: TextStyle(
          fontFamily: "Montserrat",
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                      profile: profile,
                    )));
      },
    );
  }
}

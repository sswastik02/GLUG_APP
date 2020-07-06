import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glug_app/screens/blog_screen.dart';
import 'package:glug_app/screens/event_screen.dart';
import 'package:glug_app/screens/home_screen.dart';
import 'package:glug_app/screens/linit_screen.dart';
import 'package:glug_app/screens/members_screen.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;

  Navbar(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Theme.of(context).primaryColor,
      selectedFontSize: 14.0,
      unselectedFontSize: 10.0,
      iconSize: 25.0,
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          title: Text("Events"),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.blog),
          title: Text("Blog"),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.userFriends),
          title: Text("Members"),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.book),
          title: Text("Linit"),
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, HomeScreen.id);
            break;
          case 1:
            Navigator.pushReplacementNamed(context, EventScreen.id);
            break;
          case 2:
            Navigator.pushReplacementNamed(context, BlogScreen.id);
            break;
          case 3:
            Navigator.pushReplacementNamed(context, MembersScreen.id);
            break;
          case 4:
            Navigator.pushReplacementNamed(context, LinitScreen.id);
            break;
        }
      },
    );
  }
}

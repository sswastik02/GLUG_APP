import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glug_app/screens/blog_screen.dart';
import 'package:glug_app/screens/dashboard.dart';
import 'package:glug_app/screens/event_screen.dart';
import 'package:glug_app/screens/home_screen.dart';
import 'package:glug_app/screens/linit_screen.dart';
import 'package:glug_app/screens/members_screen.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  var _currentIndex;

  List screens = [
    HomeScreen(),
    EventScreen(),
    BlogScreen(),
    MembersScreen(),
    LinitScreen(),
    Dashboard()
  ];

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color(0xFF303C42),
        selectedFontSize: 12.0,
        unselectedFontSize: 10.0,
        iconSize: 27.0,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "Home",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text(
              "Events",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.blog),
            title: Text(
              "Blog",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userFriends),
            title: Text(
              "Members",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book),
            title: Text(
              "Linit",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text(
              "Dashboard",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

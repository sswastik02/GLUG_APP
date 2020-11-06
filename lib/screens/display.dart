import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glug_app/screens/chatroom.dart';
import 'package:glug_app/screens/game_chooser_screen.dart';
import 'package:glug_app/screens/home_screen.dart';
import 'package:glug_app/screens/notice_screen.dart';
import 'package:glug_app/screens/timeline.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  var _currentIndex;

  List screens = [
    HomeScreen(),
    Timeline(),
    Chatroom(),
    NoticeScreen(),
    GameScreen()
    // EventScreen(),
    // BlogScreen(),

    // LinitScreen(),
    // Dashboard(),
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
            icon: FaIcon(FontAwesomeIcons.clock),
            title: Text(
              "Timeline",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text(
              "Chat",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            title: Text(
              "Notices",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            title: Text(
              "Games",
              style: TextStyle(fontFamily: "Montserrat"),
            ),
          ),
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

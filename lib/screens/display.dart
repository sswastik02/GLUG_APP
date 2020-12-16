import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/screens/chatroom.dart';
import 'package:glug_app/screens/home_screen.dart';
import 'package:glug_app/screens/notice_screen.dart';
import 'package:glug_app/screens/attendance_tracker_screen.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  var  _currentIndex;
  PageController _pageController;





  @override
  void initState() {
    _currentIndex = 0;
    _pageController = PageController();
    super.initState();
  }

/*List screens = [
    HomeScreen(),
    // Timeline(),
    Chatroom(),
    NoticeScreen(),
    // GameScreen()
    // EventScreen(),
    // BlogScreen(),

    // LinitScreen(),
    // Dashboard(),
  ];

  Widget _bottomNavigation(){
    return

     BottomNavigationBar(
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
          // BottomNavigationBarItem(
          //   icon: FaIcon(FontAwesomeIcons.clock),
          //   title: Text(
          //     "Timeline",
          //     style: TextStyle(fontFamily: "Montserrat"),
          //   ),
          // ),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.games),
          //   title: Text(
          //     "Games",
          //     style: TextStyle(fontFamily: "Montserrat"),
          //   ),
          // ),
          ],
          onTap: (index) {
          setState(() {
          _currentIndex = index;
          });
          },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        child:PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
            // Timeline(),
            Chatroom(),
            AttendanceTrackerScreen(),
            NoticeScreen(),
          ],
        ),
        //screens[_currentIndex],

        snackBar: SnackBar(
            content: Text('Tap back again to exit')
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
         /// _pageController.animateToPage(index,
          //    duration: Duration(milliseconds: 300), curve: Curves.ease);
          _pageController.jumpToPage(index);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text('Chat'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.track_changes),
            title:Text('Attendance') ,
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.announcement),
              title:Text('Notices') ,
            activeColor: Colors.red,
          ),

        ],
      )

    );
  }
}

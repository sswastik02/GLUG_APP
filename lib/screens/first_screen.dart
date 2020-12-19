import 'package:flutter/material.dart';
import 'package:glug_app/screens/home_screen.dart';
import 'package:glug_app/screens/notice_screen.dart';

import 'attendance_tracker_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _ctrl = PageController();
  int _currentPage = 0;
  // int _previousPage = 0;
  List<Map<String, dynamic>> data = [
    {
      "title": "Home",
      "body": "Take a deep dive into the year round activites of the club",
      "image": "images/glug_logo.jpeg",
      "color": Colors.blue[900],
      "route": HomeScreen(),
    },
    {
      "title": "Attendance\nTracker",
      "body": "Stay on track with your classes",
      "image": "images/glug_logo.jpeg",
      "color": Colors.deepOrange[700],
      "route": AttendanceTrackerScreen(),
    },
    {
      "title": "Notices",
      "body": "Never miss a notice from the institute",
      "image": "images/glug_logo.jpeg",
      "color": Colors.green[900],
      "route": NoticeScreen(),
    },
  ];
  // final ValueNotifier<double> _notifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      int next = _ctrl.page.round();

      // if (_ctrl.page.toInt() == _ctrl.page) {
      //   _previousPage = _ctrl.page.toInt();
      // }

      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }

      // _notifier?.value = _ctrl.page - _previousPage;
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _notifier?.dispose();
  }

  _buildPage(context, i) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data[i]["title"],
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w900,
              ),
            ),
            // Text(
            //   "Books.",
            //   style: Theme.of(context).textTheme.headline1,
            // ),
            // Text(
            //   "Easy.",
            //   style: Theme.of(context).textTheme.headline1,
            // ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctxt) => data[i]["route"]));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                height: screenHeight * 0.6,
                width: screenWidth * 0.88,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data[i]["body"],
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: screenWidth * 0.7,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(data[i]["image"]),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: data[i]["color"],
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildDots() {
    int items = 3;

    List<Widget> dots = [];

    for (int i = 0; i < items; i++) {
      double s = i == _currentPage ? 10.0 : 8.0;
      Color c = i == _currentPage
          ? (Theme.of(context).primaryColor == Colors.black
              ? Colors.white
              : Colors.black)
          : Colors.grey;
      dots.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 2.5),
          height: s,
          width: s,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );
    }

    return dots;
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
        child: Scaffold(
          // backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: isDrawerOpen
                        ? IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                isDrawerOpen = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.sort),
                            iconSize: 35.0,
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                xOffset = 220;
                                yOffset = 150;
                                scaleFactor = 0.6;
                                isDrawerOpen = true;
                              });
                            }),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.03,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildDots(),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _ctrl,
                    itemCount: 3,
                    itemBuilder: (ctxt, index) {
                      return _buildPage(context, index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

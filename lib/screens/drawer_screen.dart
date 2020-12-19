import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glug_app/screens/ContactUs.dart';
import 'package:glug_app/screens/about_us_screen.dart';
import 'package:glug_app/screens/attendance_tracker_screen.dart';
import 'package:glug_app/screens/dashboard.dart';
import 'package:glug_app/screens/display.dart';
import 'package:glug_app/screens/members_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/services/auth_service.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  FirestoreProvider _provider;

  /*ListTile(
  leading: Icon(FontAwesomeIcons.userFriends),
  title: Text("Our team"),
  onTap: () {
  Navigator.push(context,
  MaterialPageRoute(builder: (context) => MembersScreen()));
  },
  ),
  ListTile(
  leading: Icon(Icons.info_outline),
  title: Text("About Us"),
  onTap: () {
  Navigator.push(
  context, MaterialPageRoute(builder: (context) => AboutUS()));
  },
  ),
  ListTile(
  leading: Icon(Icons.contacts),
  title: Text("Contact Us"),
  onTap: () {
  Navigator.push(
  context, MaterialPageRoute(builder: (context) => ContactUs()));
  },
  ),
  ListTile(
  leading: Icon(Icons.track_changes),
  title: Text("Attendance Tracker"),
  onTap: () {
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => AttendanceTrackerScreen()));
  },*/

  List<Map> drawerItems = [
    {'icon': Icons.wc, 'title': "Our team", 'class': MembersScreen()},
    {'icon': Icons.info_outline, 'title': 'About Us', 'class': AboutUS()},
    {'icon': Icons.contacts, 'title': 'Contacts', 'class': ContactUs()},
    // {
    //   'icon': Icons.track_changes,
    //   'title': 'Attendance',
    //   'class': AttendanceTrackerScreen()
    // },
  ];
  @override
  void initState() {
    user = _auth.currentUser;
    _provider = FirestoreProvider();
    super.initState();
  }

  @override
  void dispose() {
    _provider = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(user.email,
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
              Column(
                children: drawerItems
                    .map((element) => Padding(
                          padding: const EdgeInsets.all(0),
                          child: ListTile(
                            leading: Icon(
                              element['icon'],
                              size: 30,
                            ),
                            title: Text(element['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => element['class']));
                            },
                          ),
                        ))
                    .toList(),
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                ),
                title: Text(
                  'Log out',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  _provider.getAuthProvider().then((value) {
                    if (value == "Google") {
                      AuthService.signOutGoogle();
                      // .whenComplete(() => Navigator.of(context).pop());
                    }
                  });
                },
              ),
            ],
          ),
        ));
  }
}

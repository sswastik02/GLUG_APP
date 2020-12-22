import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glug_app/models/themes.dart';
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
import 'package:glug_app/widgets/theme_toggle_switch.dart';
import 'package:glug_app/services/shared_pref_service.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  FirestoreProvider _provider;

  List<Map> drawerItems = [
    {'icon': Icons.wc, 'title': "Our team", 'class': MembersScreen()},
    {'icon': Icons.info_outline, 'title': 'About Us', 'class': AboutUS()},
    {'icon': Icons.contacts, 'title': 'Contacts', 'class': ContactUs()},
  ];

  bool isDarkTheme = false;

  @override
  void initState() {
    user = _auth.currentUser;
    _provider = FirestoreProvider();
    SharedPrefService.getIsDark().then((value) => {
          setState(() {
            isDarkTheme = value;
          })
        });

    super.initState();
  }

  @override
  void dispose() {
    _provider = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // isDarkTheme= Theme.of(context).primaryColor == Colors.black;
    return Scaffold(
        backgroundColor:
            isDarkTheme ? Colors.blueGrey[900] : Colors.white.withOpacity(0.95),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/back.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              // make sure we apply clip it properly
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.grey.withOpacity(0.1),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 50, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(user.email,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                        /*ThemeToggler(
                  toggleVal: isDarkTheme ,
                  onTap: () {
                    SharedPrefService.saveIsDark(!isDarkTheme);
                    setState(() {
                      isDarkTheme = !isDarkTheme;
                      Themes.changeTheme(context);
                      SharedPrefService.saveIsDark(isDarkTheme);
                    });
                  }),*/




                        Column(children: [

                          Row(
                            children: [

                              SizedBox(width: 18,),

                              Text('Theme  ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),

                              Transform.scale(
                                scale: 1.3,
                                child: Switch(
                                  value: isDarkTheme,
                                  onChanged: (value) {
                                    setState(() {
                                      isDarkTheme = !isDarkTheme;
                                      Themes.changeTheme(context);
                                      SharedPrefService.saveIsDark(isDarkTheme);
                                    });
                                  },
                                  activeThumbImage: AssetImage("images/night.png"),
                                  inactiveThumbImage: AssetImage("images/day.png"),
                                  // inactiveThumbImage: ,
                                  activeColor: Theme.of(context).accentColor,
                                ),
                              ),
                            ],
                          )

                          ,

                          Column(
                            children: drawerItems
                                .map((element) => Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: ListTile(
                                        leading: Icon(
                                          element['icon'],
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        title: Text(element['title'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      element['class']));
                                        },
                                      ),
                                    ))
                                .toList(),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.exit_to_app,
                              size: 30,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Log out',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
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
                        ]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 1000,
                            ),
                            Text(
                              "Developed By The GNU/Linux Users' Group",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}

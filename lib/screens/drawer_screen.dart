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
          padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(user.email,
                          style: TextStyle(fontWeight: FontWeight.bold))
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

              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Transform.scale(
                  scale: 1.5,
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
                     activeColor: Colors.deepOrange,
                  ),
                ),
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

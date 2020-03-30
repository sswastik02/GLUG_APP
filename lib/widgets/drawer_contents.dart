import 'package:flutter/material.dart';
import 'package:glug_app/screens/blog_screen.dart';
import 'package:glug_app/screens/event_screen.dart';
import 'package:glug_app/screens/linit_screen.dart';
import 'package:glug_app/screens/members_screen.dart';

int selectedIndex;

class DrawerContents extends StatefulWidget {
  static var categories = ['HOME', 'EVENTS', 'MEMBERS', 'BLOG', 'LINIT'];

  final int sIndex;

  DrawerContents(this.sIndex) {
    selectedIndex = sIndex;
  }

  @override
  _DrawerContentsState createState() => _DrawerContentsState();
}

class _DrawerContentsState extends State<DrawerContents> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: DrawerContents.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              switch (selectedIndex) {
                case 1:
                  Navigator.pushReplacementNamed(context, EventScreen.id);
                  break;
                case 2:
                  Navigator.pushReplacementNamed(context, MembersScreen.id);
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, BlogScreen.id);
                  break;
                case 4:
                  Navigator.pushReplacementNamed(context, LinitScreen.id);
                  break;
              }
            },
            title: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.white60,
              ),
              child: Center(
                child: Text(
                  DrawerContents.categories[index],
                  style: TextStyle(
                    color: selectedIndex == index
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

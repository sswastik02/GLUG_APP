import 'package:flutter/material.dart';

class DrawerContents extends StatefulWidget {
  static var categories = ['HOME', 'EVENTS', 'MEMBERS', 'BLOG', 'LINIT'];

  @override
  _DrawerContentsState createState() => _DrawerContentsState();
}

class _DrawerContentsState extends State<DrawerContents> {
  int selectedIndex = 0;

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
//              Navigator.of(context).pop();
            },
            title: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color:
                    selectedIndex == index ? Colors.deepOrangeAccent : Colors.white60,
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

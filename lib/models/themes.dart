import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class Themes {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    accentColor: Colors.deepOrangeAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "SourceSansPro",
    // textTheme: TextTheme(
    //   headline1: TextStyle(
    //     fontFamily: "BebasNeue",
    //     fontSize: 45.0,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   bodyText1: TextStyle(
    //     fontFamily: "SourceSansPro",
    //     fontSize: 20.0,
    //   ),
    // ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: Colors.deepOrangeAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "SourceSansPro",
    // textTheme: TextTheme(
    //   headline1: TextStyle(
    //     fontFamily: "BebasNeue",
    //     fontSize: 45.0,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   bodyText1: TextStyle(
    //     fontFamily: "SourceSansPro",
    //     fontSize: 20.0,
    //   ),
    // ),
  );

  static void changeTheme(context) {
    DynamicTheme.of(context).setThemeData(
        Theme.of(context).primaryColor == Colors.black
            ? lightTheme
            : darkTheme);
  }
}

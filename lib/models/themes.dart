import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themes {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    accentColor: Colors.deepOrangeAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Catamaran",
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: Colors.deepOrangeAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Catamaran",
  );

  static void changeTheme(context) {
    DynamicTheme.of(context).setThemeData(
        Theme.of(context).primaryColor == Colors.black
            ? lightTheme
            : darkTheme);
  }

  // static Future<bool> isDarkTheme() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   final isDarkTheme = prefs.getBool('darkTheme');

  //   return isDarkTheme == null ? true : isDarkTheme;
  // }

  // static void saveDarkTheme(bool b) async {
  //   var prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('darkTheme', b);
  // }
}

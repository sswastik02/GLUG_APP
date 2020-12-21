import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static Future<void> saveIntroDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("intro", true);
  }

  static Future<bool> getIntroDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDone = prefs.getBool("intro");
    return isDone != null ? isDone : false;
  }

  static Future<void> saveIsDark(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark", isDark);
  }

  static Future<bool> getIsDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDone = prefs.getBool("isDark");
    print("isDark : $isDone");
    return isDone != null ? isDone : false;
  }



}

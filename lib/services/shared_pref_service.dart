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
}

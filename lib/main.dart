import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glug_app/models/themes.dart';
// import 'package:glug_app/screens/firebase_messaging_demo_screen.dart';
import 'package:glug_app/screens/splash_screen.dart';
import 'package:glug_app/services/shared_pref_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  static final id = 'membersscreen';

  @override
  _MainApp createState() => _MainApp();
}



class _MainApp extends State<MainApp> {

  bool _isDark=false;

  @override
  void initState() {
    SharedPrefService.getIsDark().then((isDark) {
      setState(() {
        _isDark = isDark;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => _isDark ? Themes.darkTheme: Themes.lightTheme,
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "GLUG App",
          theme: theme,
          home: SplashScreen(),
        );
      },
    );
  }



}

/*
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => Themes.darkTheme,
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "GLUG App",
          theme: theme,
          home: SplashScreen(),
        );
      },
    );
  }
}*/

// Color(0xFF303C42)

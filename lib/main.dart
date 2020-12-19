import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/screens/display.dart';
import 'package:glug_app/screens/first_screen.dart';
// import 'package:glug_app/screens/firebase_messaging_demo_screen.dart';
import 'package:glug_app/screens/login_screen.dart';
import 'package:glug_app/screens/drawer_screen.dart';
import 'package:glug_app/screens/splash_screen.dart';
import 'package:glug_app/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

Widget _getScreen() {
  return StreamBuilder<User>(
    stream: AuthService.authStateChanges,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData)
        // return Display();
        // return IntroScreen();
        return Stack(
          children: [
            DrawerScreen(),
            FirstScreen(),
          ],
        );

      else
        return LoginScreen();
    },
  );
}

class MainApp extends StatelessWidget {
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    accentColor: Colors.deepOrangeAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Catamaran",

    // textTheme: TextTheme(
    // headline1: TextStyle(
    //     fontFamily: "Catamaran",
    //     fontSize: 45,
    //     color: Colors.white,
    //     fontWeight: FontWeight.w900),
    // bodyText1: TextStyle(
    //     fontFamily: "Catamaran",
    //     fontSize: 20,
    //     color: Colors.white,
    //     fontWeight: FontWeight.w700),

    // ),
  );

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: Colors.deepOrangeAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Catamaran",
    // textTheme: TextTheme(
    // headline1: TextStyle(
    //     fontFamily: "Catamaran",
    //     fontSize: 45,
    //     color: Colors.black,
    //     fontWeight: FontWeight.w900),
    // bodyText1: TextStyle(
    //     fontFamily: "Catamaran",
    //     fontSize: 20,
    //     color: Colors.black,
    //     fontWeight: FontWeight.w700),
    // ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GLUG App",
      theme: lightTheme,
      darkTheme: darkTheme,
      home: _getScreen(),
    );
  }
}

// Color(0xFF303C42)

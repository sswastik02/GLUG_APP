import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/models/themes.dart';
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
          home: _getScreen(),
        );
      },
    );
  }
}

// Color(0xFF303C42)

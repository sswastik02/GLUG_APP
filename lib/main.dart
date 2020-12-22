import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glug_app/models/themes.dart';
import 'package:glug_app/screens/drawer_screen.dart';
import 'package:glug_app/screens/first_screen.dart';
import 'package:glug_app/screens/intro_screen.dart';
import 'package:glug_app/screens/login_screen.dart';
// import 'package:glug_app/screens/firebase_messaging_demo_screen.dart';
import 'package:glug_app/screens/splash_screen.dart';
import 'package:glug_app/services/auth_service.dart';
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
  bool _isIntroDone = false;
  bool _isDark = false;

  @override
  void initState() {
    SharedPrefService.getIsDark().then((isDark) {
      setState(() {
        _isDark = isDark;
      });
    });
    SharedPrefService.getIntroDone().then((isDone) {
      setState(() {
        _isIntroDone = isDone;
      });
    });
    super.initState();
  }

  Widget _getScreen() {
    return StreamBuilder<User>(
      stream: AuthService.authStateChanges,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData)
          return Scaffold(
              body: DoubleBackToCloseApp(
                  snackBar: const SnackBar(
                    content: Text('Tap back again to leave'),
                  ),
                  child: Stack(
                    children: [
                      DrawerScreen(),
                      FirstScreen(),
                    ],
                  )));
        else
          return LoginScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => _isDark ? Themes.darkTheme : Themes.lightTheme,
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

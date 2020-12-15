import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/screens/display.dart';
// import 'package:glug_app/screens/firebase_messaging_demo_screen.dart';
import 'package:glug_app/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

Widget _getScreen() {
  return StreamBuilder<User>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData)
        return Display();
      else
        return LoginScreen();
    },
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GLUG App",
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        fontFamily: 'Montserrat',
      ),
      home: _getScreen(),
    );
  }
}

// Color(0xFF303C42)

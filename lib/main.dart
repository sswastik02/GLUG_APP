import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/screens/display.dart';
// import 'package:glug_app/screens/firebase_messaging_demo_screen.dart';
import 'package:glug_app/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

Widget _getScreen() {
  return StreamBuilder<FirebaseUser>(
    stream: FirebaseAuth.instance.onAuthStateChanged,
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
      ),
      home: _getScreen(),
    );
  }
}

// Color(0xFF303C42)

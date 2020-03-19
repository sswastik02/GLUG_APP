import 'package:flutter/material.dart';
import 'package:glug_app/screens/home_screen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GLUG App",
      theme: ThemeData(
        primaryColor: Color(0xFF303C42),
      ),
      home: HomeScreen(),
    );
  }
}

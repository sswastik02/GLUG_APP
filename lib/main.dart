import 'package:flutter/material.dart';
import 'package:glug_app/screens/blog.dart';
import 'package:glug_app/screens/blog_screen.dart';
import 'package:glug_app/screens/event_screen.dart';
import 'package:glug_app/screens/linit_screen.dart';

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
      home: EventScreen(),
      routes: {
        EventScreen.id: (context) => EventScreen(),
        BlogScreen.id: (context) => BlogScreen(),
        LinitScreen.id: (context) => LinitScreen(),
      },
    );
  }
}

// Color(0xFF303C42)

//import 'package:flappybird/pages/game_page.dart';
import 'package:glug_app/games/flappybird/pages/game_page.dart';
//import 'package:flappybird/styles/styles.dart';
import 'package:glug_app/games/flappybird/styles/styles.dart';
import 'package:flutter/material.dart';

class FlappyBird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flappy Bird",
      theme: ThemeData(
        backgroundColor: Palette.sky,
        fontFamily: "FlappyBird",
        textTheme: TextTheme(
          bodyText2: TextStyle(
            letterSpacing: Style.text.letterSpacing,
          ),
        ),
      ),
      home: GamePage(),
    );
  }
}

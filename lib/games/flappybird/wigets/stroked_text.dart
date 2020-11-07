//import 'package:flappybird/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/games/flappybird/styles/styles.dart';

class StrokedText extends StatelessWidget {
  const StrokedText(
    this.text, {
    this.fontSize,
    this.strokeWidth,
  });

  final String text;
  final double fontSize;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = Style.text.strokeColor,
          ),
        ),
      ],
    );
  }
}

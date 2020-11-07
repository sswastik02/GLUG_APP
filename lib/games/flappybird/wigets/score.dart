// import 'package:flappybird/game/state/score_state.dart';
// import 'package:flappybird/wigets/stroked_text.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/games/flappybird/game/state/score_state.dart';
import 'package:glug_app/games/flappybird/wigets/stroked_text.dart';

class Score extends StatelessWidget {
  const Score(this.state);

  final ScoreState state;

  @override
  Widget build(BuildContext context) => Positioned(
        left: 0,
        right: 0,
        top: state.y,
        child: Center(
          child: StrokedText(
            state.value.toString(),
            fontSize: state.fontSize,
            strokeWidth: state.strokeWidth,
          ),
        ),
      );
}

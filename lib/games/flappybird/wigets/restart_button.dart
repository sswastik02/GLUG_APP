//import 'package:flappybird/game/state/rect_state.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/games/flappybird/game/state/rect_state.dart';

class RestartButton extends StatelessWidget {
  const RestartButton(this.state, {@required this.onPressed});

  final RectState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Positioned(
        left: state.x,
        top: state.y,
        child: FlatButton(
          padding: EdgeInsets.zero,
          child: Image.asset(
            'images/restart.png',
            width: state.width,
            height: state.height,
            fit: BoxFit.fill,
          ),
          onPressed: onPressed,
        ),
      );
}

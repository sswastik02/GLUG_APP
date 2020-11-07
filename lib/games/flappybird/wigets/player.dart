//import 'package:flappybird/game/state/player_state.dart';
import 'package:flutter/widgets.dart';
import 'package:glug_app/games/flappybird/game/state/player_state.dart';
import 'package:vector_math/vector_math.dart';

class Player extends StatelessWidget {
  const Player(this.state);

  final PlayerState state;

  @override
  Widget build(BuildContext context) => Positioned(
        left: state.x,
        top: state.y,
        width: state.width,
        height: state.height,
        child: Transform.rotate(
          angle: radians(state.angle),
          child: Image.asset(
            'images/bird.png',
            width: state.width,
            height: state.height,
            fit: BoxFit.fitHeight,
            alignment: _alignment(),
          ),
        ),
      );

  AlignmentGeometry _alignment() {
    if (state.wings == Wings.down) return Alignment.centerLeft;
    if (state.wings == Wings.up) return Alignment.centerRight;
    return Alignment.center;
  }
}

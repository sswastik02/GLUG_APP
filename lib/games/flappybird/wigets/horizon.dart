// import 'package:flappybird/game/state/parallax_state.dart';
// import 'package:flappybird/wigets/buildings.dart';
import 'package:flutter/widgets.dart';
import 'package:glug_app/games/flappybird/game/state/parallax_state.dart';
import 'package:glug_app/games/flappybird/wigets/buildings.dart';

class Horizon extends StatelessWidget {
  const Horizon(this.state);

  final ParallaxState state;

  @override
  Widget build(BuildContext context) => Positioned(
        bottom: state.y,
        child: Container(
          width: state.width,
          height: state.height,
          child: Stack(
            children: [
              Buildings(
                x: state.x,
                width: state.width,
                height: state.height,
              ),
              Buildings(
                x: state.x + state.width + state.gap,
                width: state.width,
                height: state.height,
              ),
            ],
          ),
        ),
      );
}

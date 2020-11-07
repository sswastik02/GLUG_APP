// import 'package:flappybird/game/state/pillar_state.dart';
// import 'package:flappybird/wigets/pillar.dart';
import 'package:flutter/widgets.dart';
import 'package:glug_app/games/flappybird/game/state/pillar_state.dart';
import 'package:glug_app/games/flappybird/wigets/pillar.dart';

class Pillars extends StatelessWidget {
  const Pillars(this.state);

  final PillarState state;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Pillar(
            x: state.x,
            height: state.topHeight,
            isBottom: false,
            width: state.width,
            headHeight: state.headHeight,
          ),
          Pillar(
            x: state.x,
            height: state.bottomHeight,
            isBottom: true,
            width: state.width,
            headHeight: state.headHeight,
          ),
        ],
      );
}

//import 'package:flappybird/game/state/game_status.dart';
// import 'package:flappybird/game/state/parallax_state.dart';
// import 'package:flappybird/game/state/pillar_state.dart';
// import 'package:flappybird/game/state/player_state.dart';
// import 'package:flappybird/game/state/rect_state.dart';
// import 'package:flappybird/game/state/score_state.dart';

import 'package:glug_app/games/flappybird/game/state/game_status.dart';
import 'package:glug_app/games/flappybird/game/state/parallax_state.dart';
import 'package:glug_app/games/flappybird/game/state/pillar_state.dart';
import 'package:glug_app/games/flappybird/game/state/player_state.dart';
import 'package:glug_app/games/flappybird/game/state/rect_state.dart';
import 'package:glug_app/games/flappybird/game/state/score_state.dart';

import 'package:flutter/cupertino.dart';

class GameState {
  const GameState({
    @required this.player,
    @required this.horizon,
    @required this.ground,
    @required this.firstPillar,
    @required this.secondPillar,
    @required this.score,
    @required this.restartButton,
    @required this.status,
  });

  final PlayerState player;
  final ParallaxState horizon;
  final ParallaxState ground;
  final PillarState firstPillar;
  final PillarState secondPillar;
  final ScoreState score;
  final RectState restartButton;
  final GameStatus status;
}

// import 'package:flappybird/game/game.dart';
// import 'package:flappybird/game/screen_info.dart';
// import 'package:flappybird/game/state/game_state.dart';
// import 'package:flappybird/game/state/game_status.dart';
// import 'package:flappybird/styles/styles.dart';
// import 'package:flappybird/wigets/ground.dart';
// import 'package:flappybird/wigets/horizon.dart';
// import 'package:flappybird/wigets/pillars.dart';
// import 'package:flappybird/wigets/player.dart';
// import 'package:flappybird/wigets/restart_button.dart';
// import 'package:flappybird/wigets/score.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/games/flappybird/game/game.dart';
import 'package:glug_app/games/flappybird/game/screen_info.dart';
import 'package:glug_app/games/flappybird/game/state/game_state.dart';
import 'package:glug_app/games/flappybird/game/state/game_status.dart';
import 'package:glug_app/games/flappybird/styles/styles.dart';
import 'package:glug_app/games/flappybird/wigets/ground.dart';
import 'package:glug_app/games/flappybird/wigets/horizon.dart';
import 'package:glug_app/games/flappybird/wigets/pillars.dart';
import 'package:glug_app/games/flappybird/wigets/player.dart';
import 'package:glug_app/games/flappybird/wigets/restart_button.dart';
import 'package:glug_app/games/flappybird/wigets/score.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Game _game = Game();

  final int gameAreaFlex = 4;
  final int undergroundFlex = 1;

  _GamePageState() {
    _game.start();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final gameAreaFactor = (gameAreaFlex / (gameAreaFlex + undergroundFlex));

    _game.screenInfo = ScreenInfo(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * gameAreaFactor,
    );

    return Scaffold(
      backgroundColor: Palette.sky,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Column(
          children: [
            _gameArea(flex: gameAreaFlex),
            _underground(flex: undergroundFlex),
          ],
        ),
        onTap: _game.onTap,
      ),
    );
  }

  Widget _gameArea({@required int flex}) => Expanded(
        child: _gameWidgets(),
        flex: flex,
      );

  StreamBuilder<GameState> _gameWidgets() => StreamBuilder<GameState>(
        stream: _game.state,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();

          final gameState = snapshot.data;

          return Stack(
            children: [
              Horizon(gameState.horizon),
              Pillars(gameState.firstPillar),
              Pillars(gameState.secondPillar),
              Player(gameState.player),
              Ground(gameState.ground),
              ..._headsUpDisplay(gameState),
            ],
          );
        },
      );

  List<Widget> _headsUpDisplay(GameState gameState) => [
        Score(gameState.score),
        _restartButton(gameState),
      ];

  Visibility _restartButton(GameState gameState) => Visibility(
        visible: gameState.status == GameStatus.gameOver,
        child: RestartButton(
          gameState.restartButton,
          onPressed: _game.onRestart,
        ),
      );

  Widget _underground({@required int flex}) => Expanded(
        child: Container(color: Palette.underground),
        flex: flex,
      );

  @override
  void dispose() {
    _game.dispose();
    super.dispose();
  }
}

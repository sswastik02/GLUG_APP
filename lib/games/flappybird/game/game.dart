import 'dart:async';
import 'dart:math';
import 'dart:ui';

// import 'package:flappybird/game/screen_info.dart';
// import 'package:flappybird/game/state/game_status.dart';
// import 'package:flappybird/game/state/parallax_state.dart';
// import 'package:flappybird/game/state/pillar_state.dart';
// import 'package:flappybird/game/state/player_state.dart';
// import 'package:flappybird/game/state/rect_state.dart';
// import 'package:flappybird/game/state/score_state.dart';

import 'package:glug_app/games/flappybird/game/screen_info.dart';
import 'package:glug_app/games/flappybird/game/state/game_status.dart';
import 'package:glug_app/games/flappybird/game/state/parallax_state.dart';
import 'package:glug_app/games/flappybird/game/state/pillar_state.dart';
import 'package:glug_app/games/flappybird/game/state/player_state.dart';
import 'package:glug_app/games/flappybird/game/state/rect_state.dart';
import 'package:glug_app/games/flappybird/game/state/score_state.dart';

import 'package:rxdart/rxdart.dart';

import 'state/game_state.dart';

class Game {
  final _random = Random();

  Timer _timer;

  // Mutable attributes
  Duration _lastTime;
  double _elapsedTime;

  GameStatus _status;

  PlayerState _player;
  ParallaxState _horizon;
  PillarState _firstPillar;
  PillarState _secondPillar;
  ParallaxState _ground;
  ScoreState _score;
  RectState _restartButton;

  // Game state
  final _state = BehaviorSubject<GameState>();

  Stream<GameState> get state => _state;

  start() {
    _status = GameStatus.loading;
    resume();
  }

  stop() {
    _timer?.cancel();
    _lastTime = null;
  }

  void resume() {
    final framesPerSecond = 45;
    final milliseconds = 1000 ~/ framesPerSecond;
    final interval = Duration(milliseconds: milliseconds);

    _timer = Timer.periodic(
      interval,
      (Timer timer) {
        final elapsed = Duration(milliseconds: milliseconds * timer.tick);
        _onTick(elapsed);
      },
    );
  }

  ScreenInfo _screenInfo;

  set screenInfo(ScreenInfo value) {
    if (_screenInfo == null) {
      _screenInfo = value;

      reset();
    }
  }

  void reset() {
    final fontSize = _screenInfo.fontSize;
    final strokeWidth = _screenInfo.strokeWidth;

    final playerSize = _screenInfo.playerSize;
    final buildingsSize = _screenInfo.buildingsSize;
    final groundSize = _screenInfo.groundSize;
    final pillarSize = _screenInfo.pillarSize;

    final restartButtonSize = _screenInfo.restartButtonSize;

    final _initialPlayerY = _center(_screenInfo.height, playerSize.height);

    _player = PlayerState(
      x: _center(_screenInfo.width * 0.7, playerSize.width),
      y: _initialPlayerY,
      initialY: _initialPlayerY,
      width: playerSize.width,
      height: playerSize.height,
    );

    _horizon = ParallaxState(
      width: buildingsSize.width,
      height: buildingsSize.height,
      gap: _screenInfo.factor * -4,
    );

    _firstPillar = PillarState(
      width: pillarSize.width,
      headHeight: pillarSize.headHeight,
    );

    _initFirstPillar();

    _secondPillar = PillarState(
      width: pillarSize.width,
      headHeight: pillarSize.headHeight,
    );

    _initSecondPillar();

    _ground = ParallaxState(
      width: groundSize.width,
      height: groundSize.height,
      gap: _screenInfo.factor * -17,
    );

    _score = ScoreState(
      y: _screenInfo.height * 0.2,
      fontSize: fontSize,
      strokeWidth: strokeWidth,
    );

    _restartButton = RectState(
      x: _center(_screenInfo.width, restartButtonSize.width),
      y: _screenInfo.height * 0.65,
      width: restartButtonSize.width,
      height: restartButtonSize.height,
    );

    _status = GameStatus.waiting;
  }

  double _center(double screenLength, double widgetLength) =>
      (screenLength - widgetLength) / 2.0;

  _onTick(Duration elapsed) {
    if (_status == GameStatus.loading) return;

    _calculateElapsedTime(elapsed);
    _updatePlayer();
    _updateHorizon();
    _updatePillars();
    _updateGround();
    _checkCollisions();
    _notifyNewState();
  }

  _calculateElapsedTime(Duration elapsed) {
    _elapsedTime = 0.0;
    if (_lastTime != null) {
      final delta = (elapsed - _lastTime);
      _elapsedTime = delta.inMicroseconds / Duration.microsecondsPerSecond;
    }
    _lastTime = elapsed;
  }

  double value = 0;

  Wings _wingsFrame([double wingsSpeed = 1.0]) {
    final wingsIndex =
        ((_lastTime.inMilliseconds / 150 * wingsSpeed) % Wings.values.length);

    return Wings.values[wingsIndex.floor()];
  }

  _updatePlayer() {
    double y;
    double velocity;

    if (_status == GameStatus.waiting) {
      // Flying like a wave
      y = _player.initialY +
          sin(_lastTime.inMilliseconds / 150 * _screenInfo.factor) * 10;
      velocity = 0;
    } else {
      // Apply the gravity
      final gravityAcceleration =
          (_screenInfo.factor * _gravity * _elapsedTime);
      velocity = _player.velocity + gravityAcceleration;

      y = _player.y + velocity;
    }

    // Screen limits
    final maxY = _screenInfo.height - _player.height - _ground.height;

    var hitTheGround = false;

    if (y > maxY) {
      y = maxY;
      velocity = 0.0;

      _status = GameStatus.gameOver;
      hitTheGround = true;
    } else if (y < 0) {
      y = 0;
      velocity = 0.0;
    }

    var angle = _player.angle;
    var wings = Wings.middle;

    if (!hitTheGround) {
      // Rotation
      if (velocity < 0) {
        angle = lerpDouble(0, _flyUpAngle, -velocity / _player.height * 1.8);
      } else {
        angle = lerpDouble(0, _diveAngle, velocity / _player.height * 1.1);
      }

      // Wings animation
      var wingsSpeed = 1.0;

      if (velocity < 0) {
        wingsSpeed = 1.5;
      } else if (angle <= (_diveAngle * 0.8)) {
        wingsSpeed = 0.7;
      }
      wings = _wingsFrame(wingsSpeed);
    }

    _player = _player.copy(
      velocity: velocity,
      y: y,
      angle: angle,
      wings: wings,
    );
  }

  void jump() {
    _player = _player.copy(
      velocity: _jumpVelocity(),
    );
  }

  double _jumpVelocity() {
    return (_screenInfo.factor * _impulse * -1);
  }

  _updateHorizon() {
    if (_status == GameStatus.gameOver) return;

    final velocity = _screenInfo.factor * _horizonVelocity;
    var horizonX = _horizon.x - (velocity * _elapsedTime);

    final minX = -_horizon.width;

    if (horizonX < minX) {
      horizonX -= minX - _horizon.gap;
    }

    _horizon = _horizon.copy(
      x: horizonX,
    );
  }

  _updatePillars() {
    if (_status != GameStatus.playing) return;

    final velocity = _screenInfo.factor * _pillarVelocity;
    final firstPillarX = _firstPillar.x - (velocity * _elapsedTime);

    final minX = -_firstPillar.width;

    if (firstPillarX < minX) {
      _firstPillar = _secondPillar;
      _initSecondPillar();

      return;
    }

    final secondPillarX = _secondPillar.x - (velocity * _elapsedTime);

    _firstPillar = _firstPillar.copy(x: firstPillarX);
    _secondPillar = _secondPillar.copy(x: secondPillarX);
  }

  _initFirstPillar() {
    final heights = _calculateRandomHeights();

    _firstPillar = _firstPillar.copy(
      x: _screenInfo.width,
      topHeight: heights.top,
      bottomHeight: heights.bottom,
      isPlayerCrossing: false,
    );
  }

  void _initSecondPillar() {
    final heights = _calculateRandomHeights();

    _secondPillar = _secondPillar.copy(
      x: _firstPillar.x + _screenInfo.distanceBetweenPillars,
      topHeight: heights.top,
      bottomHeight: heights.bottom,
      isPlayerCrossing: false,
    );
  }

  PillarHeights _calculateRandomHeights() {
    final percentage = (_random.nextInt(4) + 2) / 10;
    final topHeight = _screenInfo.height * percentage;

    final bottomHeight =
        _screenInfo.height - _screenInfo.spaceBetweenPillars - topHeight;

    return PillarHeights(
      top: topHeight,
      bottom: bottomHeight,
    );
  }

  _updateGround() {
    if (_status == GameStatus.gameOver) return;

    final velocity = _screenInfo.factor * _pillarVelocity;
    var groundX = _ground.x - (velocity * _elapsedTime);

    final minX = -_ground.width;

    if (groundX < minX) {
      groundX -= minX - _ground.gap;
    }

    _ground = _ground.copy(
      x: groundX,
    );
  }

  void _checkCollisions() {
    final offset = _player.width * 0.1;
    final playerWidth = _player.width - (offset * 2);
    final playerX = _player.x + offset;

    final playerExtension = playerX + playerWidth;
    final pillarExtension = _firstPillar.x + _firstPillar.width;

    final isPlayerCrossing =
        ((playerExtension > _firstPillar.x) && (playerX < pillarExtension));

    final isColliding = ((_player.y < _firstPillar.topHeight) ||
        (_player.y + _player.height >
            _screenInfo.height - _firstPillar.bottomHeight));

    if (isColliding && isPlayerCrossing) {
      _status = GameStatus.gameOver;

      if (_player.velocity < 0.0) {
        _player = _player.copy(velocity: 0.0);
      }
      return;
    }

    if (isPlayerCrossing && !_firstPillar.isPlayerCrossing) {
      _firstPillar = _firstPillar.copy(isPlayerCrossing: true);
    } else if (!isPlayerCrossing && _firstPillar.isPlayerCrossing) {
      _firstPillar = _firstPillar.copy(isPlayerCrossing: false);

      _score = _score.copy(value: _score.value + 1);
    }
  }

  void onTap() {
    if (_status == GameStatus.gameOver) {
      return;
    } else if (_status == GameStatus.waiting) {
      _status = GameStatus.playing;
    }

    jump();
  }

  void onRestart() {
    reset();
    _status = GameStatus.waiting;
  }

  void _notifyNewState() {
    final newState = GameState(
      player: _player,
      horizon: _horizon,
      ground: _ground,
      firstPillar: _firstPillar,
      secondPillar: _secondPillar,
      score: _score,
      restartButton: _restartButton,
      status: _status,
    );

    _state.sink.add(newState);
  }

  dispose() {
    stop();
    _state.close();
  }
}

const double _gravity = 54.45;
const double _impulse = 9.4 * 1.3;
const double _pillarVelocity = 130.0;
const double _horizonVelocity = _pillarVelocity * 0.1;

const _diveAngle = 80;
const _flyUpAngle = -85;

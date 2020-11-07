import 'package:flutter/widgets.dart';

class ScreenInfo {
  ScreenInfo({
    @required this.width,
    @required this.height,
  }) {
    _factor = this.height / _virtualSize.height;
  }

  final double width;
  final double height;
  double _factor;

  double get factor => _factor;

  static const _virtualSize = Size(375.0, 533.6);

  static const _virtualFontSize = 48.0;
  static const _virtualStrokeWidth = 3.0;

  static const _playerVirtualSize = Size(59.0, 41.0);
  static const _buildingsVirtualSize = Size(512.0, 182.0);
  static const _groundVirtualSize = Size(512.0, 23.0);
  static const _pillarVirtualSize = PillarSize(86.0, 40.0);

  static const _restartButtonVirtualSize = Size(214.0 * 0.75, 75.0 * 0.75);

  double get fontSize => _virtualFontSize * _factor;

  double get strokeWidth => _virtualStrokeWidth * _factor;

  Size get playerSize => _playerVirtualSize * _factor;

  Size get buildingsSize => _buildingsVirtualSize * _factor;

  Size get groundSize => _groundVirtualSize * _factor;

  PillarSize get pillarSize => _pillarVirtualSize * _factor;

  double get distanceBetweenPillars => width * 0.75;

  double get spaceBetweenPillars => playerSize.height * 4;

  Size get restartButtonSize => _restartButtonVirtualSize * _factor;
}

class PillarSize {
  const PillarSize(this.width, this.headHeight);

  final double width;
  final double headHeight;

  PillarSize operator *(double operand) =>
      PillarSize(width * operand, headHeight * operand);
}

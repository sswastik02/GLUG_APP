import 'package:flutter/rendering.dart';

class Palette {
  static const sky = const Color(0xFF70C5CF);
  static const underground = const Color(0xFFDDD994);
  static const outline = const Color(0xFF533b48);
}

class Style {
  static const text = const _Text();
}

class _Text {
  const _Text();

  final letterSpacing = 2.0;
  final strokeColor = Palette.outline;
}

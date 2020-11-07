class PillarState {
  const PillarState({
    this.x = 0.0,
    this.topHeight = 0.0,
    this.bottomHeight = 0.0,
    this.width = 0.0,
    this.headHeight = 0.0,
    this.isPlayerCrossing = false,
  });

  final double x;
  final double topHeight;
  final double bottomHeight;

  final double width;
  final double headHeight;

  final bool isPlayerCrossing;

  PillarState copy({
    double x,
    double topHeight,
    double bottomHeight,
    double width,
    double headHeight,
    bool isPlayerCrossing,
  }) =>
      PillarState(
        x: x ?? this.x,
        topHeight: topHeight ?? this.topHeight,
        bottomHeight: bottomHeight ?? this.bottomHeight,
        width: width ?? this.width,
        headHeight: headHeight ?? this.headHeight,
        isPlayerCrossing: isPlayerCrossing ?? this.isPlayerCrossing,
      );
}

class PillarHeights {
  const PillarHeights({this.top = 0.0, this.bottom = 0.0});

  final double top;
  final double bottom;
}

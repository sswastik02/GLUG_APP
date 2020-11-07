class ParallaxState {
  const ParallaxState({
    this.x = 0.0,
    this.y = 0.0,
    this.width = 0.0,
    this.height = 0.0,
    this.gap = 0.0,
  });

  final double x;
  final double y;
  final double width;
  final double height;
  final double gap;

  ParallaxState copy({
    double x,
    double y,
    double width,
    double height,
  }) =>
      ParallaxState(
        x: x ?? this.x,
        y: y ?? this.y,
        width: width ?? this.width,
        height: height ?? this.height,
        gap: gap ?? this.gap,
      );
}

class RectState {
  const RectState({
    this.x = 0.0,
    this.y = 0.0,
    this.width = 0.0,
    this.height = 0.0,
  });

  final double x;
  final double y;
  final double width;
  final double height;

  RectState copy({
    double x,
    double y,
    double width,
    double height,
  }) =>
      RectState(
        x: x ?? this.x,
        y: y ?? this.y,
        width: width ?? this.width,
        height: height ?? this.height,
      );
}

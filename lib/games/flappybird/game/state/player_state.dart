class PlayerState {
  const PlayerState({
    this.velocity = 0.0,
    this.x = 0.0,
    this.y = 0.0,
    this.initialY = 0.0,
    this.angle = 0.0,
    this.width = 0.0,
    this.height = 0.0,
    this.wings = Wings.middle,
  });

  final double velocity;
  final double x;
  final double y;
  final double initialY;
  final double angle;
  final double width;
  final double height;
  final Wings wings;

  PlayerState copy({
    double velocity,
    double x,
    double y,
    double angle,
    double width,
    double height,
    Wings wings,
  }) =>
      PlayerState(
        velocity: velocity ?? this.velocity,
        x: x ?? this.x,
        y: y ?? this.y,
        initialY: initialY ?? this.initialY,
        angle: angle ?? this.angle,
        width: width ?? this.width,
        height: height ?? this.height,
        wings: wings ?? this.wings,
      );
}

enum Wings { down, middle, up }

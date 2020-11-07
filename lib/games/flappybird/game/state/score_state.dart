class ScoreState {
  const ScoreState({
    this.y = 0.0,
    this.fontSize = 16.0,
    this.strokeWidth = 1.0,
    this.value = 0,
  });

  final double y;
  final double fontSize;
  final double strokeWidth;
  final int value;

  ScoreState copy({
    double y,
    double fontSize,
    double strokeWidth,
    int value,
  }) =>
      ScoreState(
        y: y ?? this.y,
        fontSize: fontSize ?? this.fontSize,
        strokeWidth: strokeWidth ?? this.strokeWidth,
        value: value ?? this.value,
      );
}

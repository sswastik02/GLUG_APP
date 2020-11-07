import 'package:flutter/widgets.dart';

class Buildings extends StatelessWidget {
  const Buildings({
    @required this.x,
    @required this.width,
    @required this.height,
  });

  final double x;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => Positioned(
        left: x,
        child: Image.asset(
          'images/buildings.png',
          width: width,
          height: height,
          fit: BoxFit.fill,
        ),
      );
}

import 'package:flutter/widgets.dart';

class Floor extends StatelessWidget {
  const Floor({
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
          'images/floor.png',
          width: width,
          height: height,
          fit: BoxFit.fill,
        ),
      );
}

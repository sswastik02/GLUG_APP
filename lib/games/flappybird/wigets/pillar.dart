import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart';

class Pillar extends StatelessWidget {
  const Pillar({
    @required this.x,
    @required this.height,
    @required this.isBottom,
    @required this.width,
    @required this.headHeight,
  });

  final double x;
  final double height;
  final bool isBottom;

  final double width;
  final double headHeight;

  @override
  Widget build(BuildContext context) => Positioned(
        left: x,
        top: isBottom ? null : 0,
        bottom: isBottom ? 0 : null,
        child: Transform.rotate(
          angle: radians(isBottom ? 0.0 : 180.0),
          child: Stack(
            children: <Widget>[
              Image.asset(
                'images/pillar-body.png',
                width: width,
                height: height,
                repeat: ImageRepeat.repeatY,
                fit: BoxFit.fill,
              ),
              Image.asset(
                'images/pillar-head.png',
                width: width,
                height: headHeight,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      );
}

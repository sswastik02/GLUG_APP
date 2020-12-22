import 'package:flutter/material.dart';
import 'package:flare_loading/flare_loading.dart';

class Loader extends StatefulWidget {
  final bool shouldShow;

  Loader({this.shouldShow});

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool _val;

  @override
  void initState() {
    _val = widget.shouldShow;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/back3.jpg"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: FlareLoading(
        fit: BoxFit.fitHeight,
        name: 'images/Bart.flr',
        // startAnimation: 'walk',
        loopAnimation: 'Excited Hi',
        // endAnimation: 'walk',
        onSuccess: (_) {},
        onError: (_, __) {},
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/widgets/drawer_items.dart';

class Timeline extends StatefulWidget {
  static final id = 'blogscreen';

  @override
  _Timeline createState() => _Timeline();
}

class _Timeline extends State<Timeline> {
  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timeline"),
      ),
      drawer: Drawer(
        child: DrawerItems(),
      ),



    );
  }
}

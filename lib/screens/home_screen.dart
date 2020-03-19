import 'package:flutter/material.dart';
import 'package:glug_app/database/event_database.dart';
import 'package:glug_app/models/event_model.dart';
import 'package:glug_app/widgets/drawer_contents.dart';
import 'package:glug_app/widgets/event_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Event> _events = <Event>[];

  @override
  void initState() {
    super.initState();
    listenForEvents();
  }

  void listenForEvents() async {
    final Stream<Event> stream = await getEvents();
    stream.listen((Event event) => setState(() => _events.add(event)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GNU Linux Users' Group",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Center(
                  child: Image.asset(
                    'images/glug_logo.jpeg',
                    fit: BoxFit.fill,
                  ),
//                  child: CircleAvatar(
//                    radius: 60.0,
//                    backgroundImage: AssetImage('images/glug_logo.jpeg'),
//                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: DrawerContents(),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                return EventTile(event: _events[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:glug_app/database/event_database.dart';
import 'package:glug_app/models/event_model.dart';
import 'package:glug_app/widgets/drawer_contents.dart';
import 'package:glug_app/widgets/event_tile.dart';

class EventScreen extends StatefulWidget {
  static final id = 'eventscreen';

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Future<List<Event>> listenForEvents() async {
    List<Event> events = [];

    final Stream<Event> stream = await getEvents();
    stream.listen((Event event) => setState(() => events.add(event)));

    return events;
  }

  List<Event> _sort(List<Event> e) {
    e.sort((a, b) => DateTime.parse(a.event_timing)
        .toLocal()
        .compareTo(DateTime.parse(b.event_timing).toLocal()));
    return e;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EVENTS",
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/drawer_header.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: DrawerContents(1),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 5.0,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('images/glug_logo.jpeg'),
                ),
                title: Text(
                  "Developed by the GNU Linux Users' Group NITDGP",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: listenForEvents(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Event> ev = _sort(snapshot.data);
                  ev = ev.reversed.toList();

                  return ListView.builder(
                      itemCount: ev.length,
                      itemBuilder: (context, index) {
                        return EventTile(event: ev[index]);
                      });
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

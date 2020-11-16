import 'package:flutter/material.dart';
import 'package:glug_app/blocs/events_bloc.dart';
import 'package:glug_app/models/event_model.dart';
import 'package:glug_app/models/event_response.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:glug_app/widgets/event_tile.dart';

class EventScreen extends StatefulWidget {
  static final id = 'eventscreen';

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    eventsBloc.fetchAllEvents();
    super.initState();
  }

  @override
  void dispose() {
    eventsBloc.dispose();
    super.dispose();
  }

  List<Event> _sort(List<Event> e) {
    e.sort((a, b) => DateTime.parse(a.event_timing)
        .toLocal()
        .compareTo(DateTime.parse(b.event_timing).toLocal()));
    return e;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Events",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              Icon(Icons.event),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          color: Theme.of(context).primaryColor,
        ),
        Expanded(
          child: StreamBuilder(
            stream: eventsBloc.allEvents,
            builder:
                (BuildContext context, AsyncSnapshot<EventResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0)
                  return errorWidget(snapshot.data.error);
                List<Event> ev = _sort(snapshot.data.events);
                ev = ev.reversed.toList();

                return ListView.builder(
                    itemCount: ev.length,
                    itemBuilder: (context, index) {
                      return EventTile(event: ev[index]);
                    });
              } else if (snapshot.hasError) {
                return errorWidget(snapshot.error);
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}

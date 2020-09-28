import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/blocs/timeline_bloc.dart';
import 'package:glug_app/models/timeline_response.dart';
import 'package:glug_app/widgets/drawer_items.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:glug_app/widgets/timeline_tile.dart';

class Timeline extends StatefulWidget {
  static final id = 'blogscreen';
  @override
  _Timeline createState() => _Timeline();
}

class _Timeline extends State<Timeline> {
  @override
  void initState() {
    timelineBloc.fetchAllTimelineData();
    super.initState();
  }

  @override
  void dispose() {
    timelineBloc.dispose();
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
      body: StreamBuilder(
        stream: timelineBloc.allTimelineData,
        builder: (context, AsyncSnapshot<TimelineResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return errorWidget(snapshot.data.error);
            }
            return ListView.builder(
              itemCount: snapshot.data.timelines.length,
              itemBuilder: (context, index) {
                return TimelineTile(timeline: snapshot.data.timelines[index]);
              },
            );
          } else if (snapshot.hasError) {
            return errorWidget(snapshot.error);
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

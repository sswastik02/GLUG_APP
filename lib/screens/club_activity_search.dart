import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/models/event_model.dart';

import 'event_info.dart';

class ClubActivitySearch extends StatefulWidget {
  List<Event> eventList;
  ClubActivitySearch({this.eventList});

  @override
  _ClubActivitySearch createState() => _ClubActivitySearch();
}

class _ClubActivitySearch extends State<ClubActivitySearch> {
  StreamController _streamController;
  Stream _stream;
  List<Event> eventList;
  var focusNode = FocusNode();

  @override
  void initState() {
    eventList = widget.eventList;
    _streamController = StreamController();
    _stream = _streamController.stream;
    _streamController.sink.add(eventList);
    super.initState();
  }
  
  _filter(String value){
    List<Event> filteredList=new List();
    for(int i=0;i<eventList.length;i++){
      if(eventList[i].title.toLowerCase().contains(value)){
        filteredList.add(eventList[i]);
      }
    }
    _streamController.add(filteredList);
  }

  _buildEventList(List<Event> events) {
    events.removeWhere((event) => event.title == null);
    events.removeWhere((event) => DateTime.parse(event.event_timing)
        .toLocal()
        .isBefore(DateTime(DateTime.now().year - 1, 1, 1).toLocal()));
    List<Widget> eventWidgets = events
        .map(
          (item) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventInfo(event: item),
              ));
        },
        child: 
            Padding(
              padding: EdgeInsets.all(10),
                child:
        Container(
          height: 170,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: item.event_image != null
                  ? CachedNetworkImageProvider(
                item.event_image,
              )
                  : AssetImage("images/glug_logo.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: 50.0,
            child: Center(
              child: Text(
                item.title,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
          ),
        )),
      ),
    )
        .toList();

    return eventWidgets;
  }
  
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child:
        Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                    decoration: InputDecoration(
                        hintText: "Search for events"),
                  onChanged: (value) =>
                  {
                    _filter(value)
                  }
                ),
                Expanded(
                    child: StreamBuilder(
                        stream: _stream,
                        builder: (context, snapshot) {
                          return Expanded(
                            child: ListView(
                              children: _buildEventList(snapshot.data),
                            ),
                          );

                    }))
              ],
            )),
    )
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/widgets/error_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  FirestoreProvider _provider;

  @override
  void initState() {
    _provider = FirestoreProvider();
    super.initState();
  }

  @override
  void dispose() {
    _provider = null;
    super.dispose();
  }

  _buildEventList(DocumentSnapshot data) {
    List<dynamic> events = data["eventDetail"];
    List<Widget> dataWidget;

    dataWidget = events.map((event) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                event["name"] + " ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  fontSize: 15.0,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                color: Colors.white,
                iconSize: 18.0,
                onPressed: () {
                  _provider.removeEventData(data, event);
                },
              )
            ],
          ),
        ),
      );
    }).toList();

    return ListView(
      children: dataWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller1 = TextEditingController();
    TextEditingController _controller2 = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Event Detail",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: _provider.fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Add an event",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  autocorrect: false,
                                  controller: _controller1,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      hintText: "Event name",
                                      labelText: "Enter an event"),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                TextField(
                                  autocorrect: false,
                                  controller: _controller2,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      hintText: "Rating",
                                      labelText:
                                          "Enter event rating out of 10"),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              if (_controller1.text.toString().length != 0 &&
                                  _controller2.text.toString().length != 0) {
                                Map<String, dynamic> event;

                                event = {
                                  "name": _controller1.text.toString(),
                                  "rating": double.parse(
                                      _controller2.text.toString()),
                                };

                                _controller1.clear();
                                _controller2.clear();
                                _provider.addEventData(snapshot.data, event);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Events participated in",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: (snapshot.data["eventDetail"] != null &&
                              snapshot.data["eventDetail"].length != 0)
                          ? _buildEventList(snapshot.data)
                          : Text(
                              "No data added yet",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14.0,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError)
              return errorWidget(snapshot.error);
            else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

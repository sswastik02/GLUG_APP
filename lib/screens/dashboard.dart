import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/screens/profile_edit_screen.dart';
import 'package:glug_app/services/auth_service.dart';
import 'package:glug_app/widgets/drawer_items.dart';
import 'package:glug_app/widgets/error_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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

  _buildEventsWidget(List<dynamic> events) {
    List<Widget> dataWidget;
    dataWidget = events.map((data) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            data + " ",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Container(
        height: 175.0,
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 3.3,
          // shrinkWrap: true,
          children: dataWidget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: StreamBuilder(
          stream: _provider.fetchUserData(),
          builder:
              (BuildContext ctxt, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot userData = snapshot.data;
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                }),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontFamily: "BebasNeue",
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: CircleAvatar(
                                radius: 40.0,
                                backgroundImage:
                                    NetworkImage(userData["photoURL"])),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userData["name"],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userData["email"],
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 5.0),
                            Text(
                              "Events Interested In",
                              style: TextStyle(
                                fontFamily: "BebasNeue",
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // IconButton(
                            //   iconSize: 20.0,
                            //   icon: Icon(Icons.edit),
                            //   onPressed: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 ProfileEditScreen()));
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      (userData["interested"] == null ||
                              userData["eventDetail"].length == 0)
                          ? Text(
                              "No data added yet",
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            )
                          : _buildEventsWidget(userData["interested"]),
                      SizedBox(
                        height: 25.0,
                      ),
                      // RaisedButton(
                      //   elevation: 5.0,
                      //   splashColor: Colors.redAccent,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(40.0)),
                      //   color: Colors.red,
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //       Icon(
                      //         Icons.exit_to_app,
                      //         color: Colors.white,
                      //         size: 30.0,
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(left: 10.0),
                      //         child: Text(
                      //           "Logout",
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontFamily: "Montserrat",
                      //             fontSize: 18.0,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   onPressed: () {
                      //     _provider.getAuthProvider().then((value) {
                      //       if (value == "Google") {
                      //         AuthService.signOutGoogle().whenComplete(
                      //             () => Navigator.of(context).pop());
                      //       }
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError)
              return Center(child: errorWidget("No data found"));
            else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

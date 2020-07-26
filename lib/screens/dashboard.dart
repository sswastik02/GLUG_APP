import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/screens/login_screen.dart';
import 'package:glug_app/services/auth_service.dart';
import 'package:glug_app/widgets/error_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirestoreProvider provider = FirestoreProvider();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: provider.fetchUserData(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot userData = snapshot.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                          backgroundImage: NetworkImage(userData["photoUrl"]),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userData["name"],
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userData["email"],
                            style: TextStyle(
                              fontFamily: "Montserrat",
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
                  RaisedButton(
                    elevation: 5.0,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                          size: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                fontFamily: "Montserrat", fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      signOutGoogle().whenComplete(() {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }),
                        );
                      });
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError)
            return Center(child: errorWidget("No data found"));
          else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

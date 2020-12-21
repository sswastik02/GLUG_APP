import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glug_app/widgets/drawer_items.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:glug_app/widgets/subject_form.dart';
import 'package:glug_app/resources/database_provider.dart';
import 'dart:async';
import 'package:glug_app/blocs/attendance_bloc.dart';

class AttendanceTrackerScreen extends StatefulWidget {
  @override
  _AttendanceTrackerScreenState createState() =>
      _AttendanceTrackerScreenState();
}

class _AttendanceTrackerScreenState extends State<AttendanceTrackerScreen> {
  StreamController _streamController;
  Stream _stream;
  List<Map> list;
  DatabaseProvider _databaseProvider;

  @override
  void initState() {
    super.initState();
    //_provider = FirestoreProvider();
    _databaseProvider = DatabaseProvider.databaseProvider;
    _streamController = StreamController();
    _stream = _streamController.stream;
    attendanceBloc.fetchAllData();
    getData();
  }

  getData() async {
    list = await _databaseProvider.getAttendanceData();
    _streamController.add(list);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _addSubjectDialog(context, map) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).primaryColor == Colors.black
                  ? Colors.blueGrey[900]
                  : Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
              ],
            ),
            child: SubjectForm(map: map),
          ),
        );
      },
    );
  }

  void _optionsModalBottomSheet(context, Map map) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.umbrella),
                  title: new Text('Mark Holiday'),
                  onTap: () => {
                    _databaseProvider.addHoliday(map),
                    Navigator.of(context).pop()
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.cancel),
                  title: new Text('Mark Class canceled'),
                  onTap: () => {
                    _databaseProvider.addCanceled(map),
                    Navigator.of(context).pop()
                  },
                ),
                new ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text('Delete Subject'),
                    onTap: () => {
                          _databaseProvider.deleteSubject(map),
                          Navigator.of(context).pop()
                        }),
                new ListTile(
                  leading: new Icon(Icons.create),
                  title: new Text('Edit Attendance details'),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    _addSubjectDialog(context, map),
                  },
                ),
              ],
            ),
          );
        });
  }

  _getStatus(int total, int attended, int goal) {
    double percent = total != 0 ? attended / total : 0;
    double g = goal / 100;

    if (total == 0) {
      return "Classes not started";
    } else if (percent >= g) {
      int t = (attended / g).floor();
      int diff = t - total;

      if (diff == 0) {
        return "On Track, You can't miss the next class";
      } else if (diff == 1) {
        return "On Track, You may leave the next class";
      } else {
        return "On Track, You may leave the next $diff classes";
      }
    } else if (percent < g) {
      int a = attended;
      int t = total;
      while ((a / t).toDouble() < g) {
        a++;
        t++;
      }
      int diff = t - total;

      if (diff == 1) {
        return "Attend the next class to get back on track";
      } else {
        return "Attend the next $diff classes to get back on track";
      }
    }
  }

  _buildTiles(List<dynamic> subjects) {
    List<Widget> data;
    data = subjects.map((sub) {
      return Container(
          padding: EdgeInsets.all(10),
          child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sub["name"].toString().length <= 12
                                ? sub["name"]
                                : sub["name"].toString().substring(0, 12) +
                                    "...",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.more_horiz),
                            //iconSize: 20.0,
                            onPressed: () {
                              _optionsModalBottomSheet(context, sub);
                            },
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Goal: ${sub["goal"]}%",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Attendance : ${sub['attended']} / ${sub['total']}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Total Holidays : ${sub["holiday"]}",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Classes Canceled: ${sub["canceled"]}",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove_circle),
                                      // iconSize: 20.0,
                                      onPressed: () {
                                        _databaseProvider.addNotAttedanded(
                                            sub["id"], sub["total"]);
                                      },
                                      color: Colors.red,
                                      constraints:
                                          BoxConstraints(maxHeight: 30),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_circle),
                                      // iconSize: 20.0,
                                      onPressed: () {
                                        _databaseProvider.addAttedance(
                                            sub["id"],
                                            sub["total"],
                                            sub["attended"]);
                                      },
                                      color: Colors.green,
                                      constraints:
                                          BoxConstraints(maxHeight: 30),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: LinearProgressIndicator(
                                    value: sub["total"] != 0
                                        ? sub["attended"] / sub["total"]
                                        : 0,
                                    backgroundColor: Colors.red,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${sub["total"] != 0 ? (sub["attended"] / sub["total"] * 100).round() : 0}%",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ]),
                      SizedBox(height: 8),
                      Text(
                        "Status: ${_getStatus(sub["total"], sub["attended"], sub["goal"])}",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ]),
              )));
    }).toList();

    return ListView(
      children: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    final progDim = MediaQuery.of(context).size.width * 0.3;

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                        'Attendance Tracker',
                        style: TextStyle(
                          fontFamily: "BebasNeue",
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 30,
                    ),
                    onPressed: () {
                      _addSubjectDialog(context, null);
                    },
                  ),
                ]),
          ),
          Expanded(
            child: StreamBuilder(
                stream: attendanceBloc.allAttendanceData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> subs = snapshot.data;

                    var attended = 0;
                    var total = 0;
                    subs.forEach((sub) {
                      attended += sub["attended"];
                      total += sub["total"];
                    });

                    var percentage =
                        total != 0 ? (attended / total * 100).round() : 0;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: progDim,
                              width: progDim,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      height: progDim + 20,
                                      width: progDim,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.green),
                                        backgroundColor: Colors.red,
                                        value: percentage / 100,
                                        strokeWidth: 8.0,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "$percentage%",
                                      style: TextStyle(
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Total Classes: $total",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  "Classes Attended: $attended",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: _buildTiles(snapshot.data),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return errorWidget(snapshot.error);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ]));
  }
}

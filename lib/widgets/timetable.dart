import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:glug_app/blocs/timetable_bloc.dart';
import 'package:glug_app/models/timetable_response.dart';
import 'package:glug_app/resources/database_provider.dart';
import 'package:glug_app/resources/routine_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'subject_routine.dart';

String section;
int year;
dynamic data;
RoutineData routineData = RoutineData();

class TimeTable extends StatefulWidget {
  TimeTable(String x, int y) {
    section = x;
    year = y;
  }
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  //  getData()async{
  //   CollectionReference timetable =
  //   FirebaseFirestore.instance.collection('timetable');
  //   QuerySnapshot querySnapshot = await timetable.get();
  //   List<QueryDocumentSnapshot> lqds = querySnapshot.docs;
  //   DocumentSnapshot documentSnapshot = await timetable.doc(lqds[year-1].id).get();
  //   setState(() {
  //     data = documentSnapshot.data();
  //   });
  //
  // }
  // void colorSc()async{
  //   RoutineData routineData = RoutineData();
  //   var set = <String>{};
  //   for(var i = 0;i<11;i++){
  //     for( var j =0;j<6;j++){
  //       if(data[section]["${i}"][j]!="" && data[section]["${i}"][j].toString().length==5)
  //       set.add(data[section]["${i}"][j].toString());
  //     }
  //   }
  //   // print(color);
  //   int c=1;
  //   set.forEach((element) {
  //     setState(() {
  //       color[element]=routineData.colorScheme[c];
  //       c++;
  //     });
  //   });
  //
  //
  // }
  StreamController _streamController;
  List<Map> list;
  DatabaseProvider _databaseProvider;

  @override
  void initState() {
    super.initState();
    //_provider = FirestoreProvider();
    _databaseProvider = DatabaseProvider.databaseProvider;
    _streamController = StreamController();
    getData();
  }

  getData() async {
    List<Map> timetable;
    try {
      await _databaseProvider.getTimeTableData();
    } catch (error, stacktrace) {
      print("Error: $error, Stacktrace = $stacktrace");
      await _databaseProvider.createTimetable();
    }
    timetable = await _databaseProvider.getTimeTableData();
    timeTableBloc.fetchAllData();
    _streamController.add(timetable);
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
            height: MediaQuery.of(context).size.height * 0.65,
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
            child: SubjectRoutine(map: map),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    data = routineData.data;
    // getData();
    // colorSc();
    return
        // (data==null || color==null)?Center(child: CircularProgressIndicator()):
        Padding(
      padding: const EdgeInsets.fromLTRB(9, 0, 9, 7),
      child: StreamBuilder(
          stream: timeTableBloc.allTimeTableData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data;
              data = timetableFromMap(data);
              return Container(
                  child: GridView.count(
                      crossAxisCount: 6,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: List.generate(
                        66,
                        (index) {
                          return Padding(
                              padding: const EdgeInsets.all(3),
                              child: InkWell(
                                onTap: () {
                                  if (!((index / 6).toInt() == 0 ||
                                      index % 6 == 0)) {
                                    _addSubjectDialog(context, {
                                      'name':
                                          "${data[(index / 6).toInt()][index % 6]}",
                                      'time': "${data[(index / 6).toInt()][0]}",
                                      'day': "${data[0][index % 6]}",
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ((index / 6).toInt() == 0 ||
                                              index % 6 == 0)
                                          ? DynamicTheme.of(context).themeId ==
                                                  1
                                              ? Colors.black
                                              : Colors.white
                                          : Colors.grey.shade200
                                      // color:(data[section]["${(index/6).toInt()}"][index%6]!=null)?color[data[section]["${(index/6).toInt()}"][index%6]]:DynamicTheme.of(context).themeId==1 ? Colors.white : Colors.black,
                                      ),
                                  child: Center(
                                      child: Transform(
                                          alignment: FractionalOffset.center,
                                          transform: new Matrix4.identity()
                                            ..rotateZ(0 * 3.1415927 / 180),
                                          child: ((index / 6).toInt() == 0 ||
                                                  index % 6 == 0)
                                              ? Text(
                                                  "${data[(index / 6).toInt()][index % 6]}",
                                                  // "1",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.046,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              : Text(
                                                  "${data[(index / 6).toInt()][index % 6]}")
                                          // child: Text("${data[section]["${(index/6).toInt()}"][index%6]}",
                                          // style: TextStyle(
                                          //   fontSize: MediaQuery.of(context).size.width * 0.046,
                                          //   fontWeight: FontWeight.w600
                                          // ),
                                          // ),

                                          )),
                                ),
                              ));
                        },
                      )));
            } else if (snapshot.hasError) {
              return errorWidget(snapshot.error);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

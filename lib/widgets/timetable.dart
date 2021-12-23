import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:glug_app/resources/routine_data.dart';

String section;
class TimeTable extends StatefulWidget {



   TimeTable(String x){
     section=x;
   }

  @override
  _TimeTableState createState() => _TimeTableState();
}



class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> data;  Map<String,dynamic> color;
    RoutineData routineData = RoutineData();
    data = routineData.data; color = routineData.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(9, 0, 9, 7),
      child: Container(
         child:  GridView.count(
          crossAxisCount: 6,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: List.generate(66, (index) {
        return Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:(data[section][(index/6).toInt()][index%6]!=null)?color[data[section][(index/6).toInt()][index%6]]:DynamicTheme.of(context).themeId==1 ? Colors.white : Colors.black,
            ),
           child: Center(child: Transform(
             alignment: FractionalOffset.center,
             transform: new Matrix4.identity()
               ..rotateZ(0 * 3.1415927 / 180),
             child: Text("${data[section][(index/6).toInt()][index%6]}",
             style: TextStyle(
               fontSize: MediaQuery.of(context).size.width * 0.046,
               fontWeight: FontWeight.w600
             ),
             ),
           )),
        )
        );
      },
         )
         )
      ),
    );
  }
}

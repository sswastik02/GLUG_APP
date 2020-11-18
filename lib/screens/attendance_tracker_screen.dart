import 'package:flutter/material.dart';
import 'package:glug_app/widgets/drawer_items.dart';

class AttendanceTrackerScreen extends StatefulWidget {
  @override
  _AttendanceTrackerScreenState createState() =>
      _AttendanceTrackerScreenState();
}

class _AttendanceTrackerScreenState extends State<AttendanceTrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Tracker"),
      ),
      drawer: Drawer(
        child: DrawerItems(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AttendanceTile(),
                AttendanceTile(),
                AttendanceTile(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AttendanceTile(),
                AttendanceTile(),
                AttendanceTile(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AttendanceTile(),
                AttendanceTile(),
                AttendanceTile(),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Stack(
              children: [
                SizedBox(
                  height: 150.0,
                  width: 150.0,
                  child: CircularProgressIndicator(
                    value: 0.6,
                    strokeWidth: 10.0,
                  ),
                ),
                Container(
                  child: Text(
                    "15/25",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 120.0,
        width: 120.0,
        child: Center(
          child: Text("Tile"),
        ),
      ),
    );
  }
}

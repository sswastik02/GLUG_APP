import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:glug_app/models/timeline_model.dart';
import 'package:glug_app/screens/webpage.dart';

class TimelineTile extends StatelessWidget {
  final Timeline timeline;

  TimelineTile({this.timeline});
  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  Widget _getDate(String timing) {
    DateTime dateTime = DateTime.parse(timing).toLocal();
    var month = dateTime.month;
    var day = dateTime.day;
    var year = dateTime.year;
    var m = months[month - 1];
    Widget txt1 = Text(
      m.substring(0, 3),
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
    Widget txt2 = Text(
      m.substring(3),
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrange,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );

    var date = " $day, $year";
    Widget txt3 = Text(
      date,
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrangeAccent,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );

    return Row(
      children: <Widget>[
        txt1,
        txt2,
        txt3,
        SizedBox(
          width: 16.0,
        ),
        Icon(
          Icons.calendar_today,
          color: Colors.deepOrangeAccent,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
          elevation: 8,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                /*Text(timeline.eventName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
                Text(
                    timeline.eventName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Html(
                  data: timeline.detail,
                  //Optional parameters:
                  padding: EdgeInsets.all(8.0),

                  defaultTextStyle: TextStyle(fontFamily: "Montserrat"),
                  linkStyle: const TextStyle(
                    color: Colors.blueAccent,
                  ),
                  useRichText: false,
                  onLinkTap: (url) {
                    print("Opening $url");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebPage(
                                  URL: url,
                                )));
                  },
                  onImageTap: (src) {
                    // Display the image in large form.
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                _getDate(timeline.eventTime)
              ],
            ),
          )),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:glug_app/models/timeline_model.dart';
import 'package:url_launcher/url_launcher.dart';

class TimelineTile extends StatelessWidget {
  final Timeline timeline;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    );
    Widget txt2 = Text(
      m.substring(3),
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrange,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    );

    var date = " $day, $year";
    Widget txt3 = Text(
      date,
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrangeAccent,
        fontSize: 15.0,
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
          size: 15,
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
                    _launchURL(url);
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

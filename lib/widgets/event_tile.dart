import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:glug_app/models/event_model.dart';
import 'package:glug_app/screens/webpage.dart';
import 'package:html/parser.dart';
import 'package:date_format/date_format.dart';

class EventTile extends StatelessWidget {
  final Event event;

  EventTile({this.event});

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

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  String _getTime(String timing) {
    DateTime dateTime = DateTime.parse(timing).toLocal();
    var time = formatDate(dateTime, [HH, ':', nn, ':', ss]);
    return time;
  }

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
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
    Widget txt2 = Text(
      m.substring(3),
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrange,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );

    var date = " $day, $year";
    Widget txt3 = Text(
      date,
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrangeAccent,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );

    return Row(
      children: <Widget>[
        SizedBox(
          width: 10.0,
        ),
        txt1,
        txt2,
        txt3,
//        Text(
//          _getDate(event.event_timing),
//          style: TextStyle(
//            fontSize: 18.0,
//            fontWeight: FontWeight.bold,
//          ),
//        ),
        SizedBox(
          width: 15.0,
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20.0,
      ),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 10.0,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(
                height: 250.0,
              ),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: event.event_image != null
                      ? NetworkImage(event.event_image)
                      : AssetImage('images/glug_logo.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0, right: 140.0),
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(210, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
                child: _getDate(event.event_timing),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 10.0,
              ),
              child: Text(
                event.title,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.watch_later,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  _getTime(event.event_timing),
                  style: TextStyle(
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(Icons.location_on),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  event.venue != null ? event.venue : 'Online',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
//            Padding(
//              padding: EdgeInsets.symmetric(
//                horizontal: 10.0,
//                vertical: 10.0,
//              ),
//              child: Text(
//                _parseHtmlString(event.description),
//                overflow: TextOverflow.visible,
//                style: TextStyle(
//                  color: Colors.grey,
//                ),
//              ),
//            ),
            Html(
              data: event.description,
              //Optional parameters:
              padding: EdgeInsets.all(8.0),

              defaultTextStyle:
                  TextStyle(fontFamily: "Montserrat", color: Colors.grey),
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
          ],
        ),
      ),
    );
  }
}

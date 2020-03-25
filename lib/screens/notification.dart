import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  var initializationSettingAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializationSettingAndroid = AndroidInitializationSettings('glug_logo');
    initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        initializationSettingAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) debugPrint('Notification payload: $payload');

    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondRoute()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('OK'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondRoute()));
            },
          )
        ],
      ),
    );
  }

  void _showNotification() async {
    await _demoScheduledNotification();
  }

  Future<void> _demoNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel ID',
      'channel name',
      'channel description',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'test ticker',
    );

    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iosChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'Hello', 'A message from Flutter', platformChannelSpecifics,
        payload: 'test payload');
  }

  Future<void> _demoScheduledNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Hello',
        'A scheduled message from Flutter',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Example'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Press button to schedule notification'),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.notifications),
          onPressed: () {
            final snackBar = SnackBar(
              content: Text('Notification scheduled'),
            );
            Scaffold.of(context).showSnackBar(snackBar);
            _showNotification();
          },
        );
      }),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go Back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

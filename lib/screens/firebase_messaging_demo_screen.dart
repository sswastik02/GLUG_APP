import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingDemoApp extends StatefulWidget {
  @override
  _FirebaseMessagingDemoAppState createState() =>
      _FirebaseMessagingDemoAppState();
}

class _FirebaseMessagingDemoAppState extends State<FirebaseMessagingDemoApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  List<Message> _messages;

  _getToken() {
    _fcm.getToken().then((deviceToken) {
      print('Device token: $deviceToken');
    });
  }

  _configureFirebaseListeners() {
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      _setMessage(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');
      _setMessage(message);
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
      _setMessage(message);
    });
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final title = notification['title'];
    final body = notification['body'];
    final mMessage = data['message'];

    setState(() {
      Message m = new Message(title, body, mMessage);
      _messages.add(m);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messages = List<Message>();
    _getToken();
    _configureFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Cloud Messaging'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _messages == null ? 0 : _messages.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                _messages[index].message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Message {
  String title;
  String body;
  String message;

  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}

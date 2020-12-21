import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/services/auth_service.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:glug_app/secret_keys.dart' as SecretKey;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription _subs;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    _initDeepLinkListener();
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    _subs = getLinksStream().listen((String link) {
      _checkDeepLink(link);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      AuthService.signInWithGitHub(code).then((user) async {
        print("LOGGED IN AS: " + user.displayName);
        DocumentSnapshot doc =
            await _firestore.collection("/users").doc(user.uid).get();

        if (!doc.exists) {
          _firestore.collection("/users").doc(user.uid).set({
            "name": user.displayName,
            "email": user.email,
            "photoURL": user.photoURL,
            "eventDetail": [],
            "starred_notices": [],
            "interested": []
          });
        }
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
      _subs = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/back.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Container(
                width: (MediaQuery.of(context).size.width),
                height: 50,
                color: Colors.black54,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "GNU LIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "UX US",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      Text(
                        "ERS' GR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "OUP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage("images/glug_logo.jpeg"),
              ),
              SizedBox(height: 70),
              _signInButton(type: "Google", context: context),
              SizedBox(height: 20),
              // _signInButton(type: "GitHub", context: context),
            ],
          ),
        ),
      ),
    );
  }

  void _onClickGitHubLoginButton() async {
    const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        SecretKey.GITHUB_CLIENT_ID +
        "&scope=public_repo%20read:user%20user:email";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      print("CANNOT LAUNCH THIS URL!");
    }
  }

  Widget _signInButton({String type, BuildContext context}) {
    return RaisedButton(
      elevation: 10.0,
      splashColor: Colors.grey,
      onPressed: () {
        if (type == "Google") {
          AuthService.signInWithGoogle();
        } else if (type == "GitHub") {
          _onClickGitHubLoginButton();
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: type == "Google"
                    ? AssetImage("images/google_logo.png")
                    : AssetImage("images/github_logo.png"),
                height: 35.0),
            SizedBox(
              width: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                type == "Google"
                    ? 'Sign in with Google'
                    : 'Sign in with GitHub',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontFamily: "Montserrat",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

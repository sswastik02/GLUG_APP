import 'package:flutter/material.dart';
import 'package:glug_app/screens/display.dart';
import 'package:glug_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orangeAccent,
              Colors.redAccent,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage("images/glug_logo.jpeg"),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "GLUG App",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              _signInButton(type: "Google"),
              SizedBox(height: 20.0),
              // _signInButton(type: "Facebook"),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedGoogleSignInButton() async {
    String status = await signInWithGoogle();

    if (status == "Success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Display();
          },
        ),
      );
    }
  }

  Widget _signInButton({String type}) {
    return RaisedButton(
      elevation: 10.0,
      splashColor: Colors.grey,
      onPressed: () {
        if (type == "Google") {
          _onPressedGoogleSignInButton();
        } else {} // Facebook Login
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
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
                    : AssetImage("images/fb_logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                type == "Google"
                    ? 'Sign in with Google'
                    : 'Sign in with Facebook',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
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

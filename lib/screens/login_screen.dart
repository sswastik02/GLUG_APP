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
                        "ER'S GR",
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
              RaisedButton(
                elevation: 10.0,
                splashColor: Colors.grey,
                onPressed: () {
                  _onPressedGuestSignInButton();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Image(
                      //     image:
                      //     height: 35.0),
                      // SizedBox(
                      //   width: 5.0,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in as Guest',
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
              ),
              SizedBox(height: 20.0),
              _signInButton(type: "Google"),
              SizedBox(height: 20.0),
              _signInButton(type: "Facebook"),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedGuestSignInButton() async {
    String status = await signInGuest();

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

  void _onPressedFbSignInButton() async {
    String status = await signInWithFacebook();

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
        } else if (type == "Facebook") {
          _onPressedFbSignInButton();
        } // Facebook Login
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
                    : AssetImage("images/fb_logo.png"),
                height: 35.0),
            SizedBox(
              width: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                type == "Google"
                    ? 'Sign in with Google'
                    : 'Sign in with Facebook',
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

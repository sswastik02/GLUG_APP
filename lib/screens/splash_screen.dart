import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/screens/drawer_screen.dart';
import 'package:glug_app/screens/intro_screen.dart';
import 'package:glug_app/services/auth_service.dart';
import 'package:glug_app/services/shared_pref_service.dart';
import 'package:lottie/lottie.dart';

import 'first_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isIntroDone = false;
  Widget _getScreen() {
    return StreamBuilder<User>(
      stream: AuthService.authStateChanges,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData)
          return Stack(
            children: [
              DrawerScreen(),
              FirstScreen(),
            ],
          );
        else
          return LoginScreen();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    SharedPrefService.getIntroDone().then((isDone) {
      setState(() {
        _isIntroDone = isDone;
      });
    });
    Timer(
      Duration(seconds: 8),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return _isIntroDone ? _getScreen() : IntroScreen();
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Lottie.asset(
                "images/snowing.json",
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    alignment: Alignment.center,
                    child: Text(
                      "THE GNU/LINUX\nUSERS' GROUP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    // color: Colors.white,
                    alignment: Alignment.center,
                    child: FlareLoading(
                        fit: BoxFit.fitHeight,
                        name: 'images/penguin_nodding.flr',
                        // startAnimation: 'walk',
                        loopAnimation: 'walk',
                        // endAnimation: 'walk',
                        onSuccess: (_) {},
                        onError: (_, __) {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

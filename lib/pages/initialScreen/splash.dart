import '../../shared/colors.dart';
import '../../shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    Future.delayed(Duration(seconds: 7), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/dulangLogo.png',
              // height: 100,
              width: 200,
              fit: BoxFit.fitWidth,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("We ", style: TextStyle(color: grey, fontSize: 30.0)),
                RotateAnimatedTextKit(
                  text: ["Care.", "Share.", "Save."],
                  textStyle: splashStyle,
                  textAlign: TextAlign.start,
                  alignment: AlignmentDirectional.topStart,
                  isRepeatingAnimation: false,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

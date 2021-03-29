//import 'package:dulang_new/pages/editProfile.dart';
import 'package:dulang_new/pages/initialScreen/login.dart';
import 'package:dulang_new/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:dulang_new/pages/home.dart';
import 'package:dulang_new/pages/initialScreen/splash.dart';

import 'package:dulang_new/pages/initialScreen/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: primaryColor),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/signup': (context) => Signup()
      },
    );
  }
}
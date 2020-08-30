import 'package:easy_blood/findRequest.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/home.dart';
import 'package:easy_blood/locate_user.dart';
import 'package:easy_blood/onboarding.dart';
import 'package:easy_blood/requestBlood.dart';
import 'package:easy_blood/signin.dart';
import 'package:easy_blood/splash.dart';
import 'package:easy_blood/test.dart';
import 'package:easy_blood/userdashboard.dart';
import 'package:easy_blood/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:geolocation/geolocation.dart';
import 'package:provider/provider.dart';
import 'package:easy_blood/geolocation_service.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
final locaterService = GeolocationService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => LocateUser(),
      }
    );
  }
}
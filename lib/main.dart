import 'package:easy_blood/admin/dashboard/dashboard.dart';
import 'package:easy_blood/home/home.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/onboarding.dart';
import 'package:easy_blood/profile/edit_profile.dart';
import 'package:easy_blood/profile/profile.dart';
import 'package:easy_blood/service/geolocation_service.dart';
import 'package:easy_blood/splash.dart';
import 'package:easy_blood/test.dart';
import 'package:easy_blood/welcome/welcome.dart';
import 'package:flutter/material.dart';

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
        '/onboarding': (BuildContext context) => Onboarding(),
        '/home': (BuildContext context) => Home(),
        '/welcome': (BuildContext context) => Welcome(),
        '/loading': (BuildContext context) => LoadingScreen(),
        '/test': (BuildContext context) => MyApp(),
        '/profile': (BuildContext context) => Profile(),
        '/editprofile': (BuildContext context) => EditProfile(),
        '/dashboard': (BuildContext context) => Dashboard(),

      }
    );
  }
}


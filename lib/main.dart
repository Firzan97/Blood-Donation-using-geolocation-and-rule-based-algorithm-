import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/profile/edit_profile.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/home/home.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/admin/dashboard/dashboard.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/onboarding.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/profile/profile.dart';
import 'package:easy_blood/splash.dart';
import 'package:easy_blood/test.dart';
import 'package:easy_blood/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/service/geolocation_service.dart';

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


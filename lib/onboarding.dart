import 'package:easy_blood/body.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/welcome/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        theme: ThemeData(
          fontFamily: "Muli",
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(body: SplashScreen()

        ));
  }
}

import 'dart:async';

import 'package:easy_blood/animation/faceAnimation.dart';
import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    var _duration = new Duration( seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState(){
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 200),
          child: FadeAnimation(2,Column(
          children: <Widget>[
            Center(child: Image.asset("assets/images/blood.png",scale: 4,)),
              Text(
                "EASY BLOOD",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),)
        ),
      ),
    );
  }
}

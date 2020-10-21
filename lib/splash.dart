import 'dart:async';
import 'dart:convert';
import 'package:easy_blood/animation/faceAnimation.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  var user = null;
  startTime() async {
    var _duration = new Duration( seconds: 5);
    return new Timer(_duration, navigationPage);
  }


  void navigationPage()async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      user= pref.getString("user");
      print("babii llaaa2222");

      if (user!=null){
        user =jsonDecode(user);
        if(user["role"]=="admin"){
          Navigator.of(context).pushReplacementNamed('/dashboard');
        }
        else{
          Navigator.of(context).pushReplacementNamed('/home');
        }

      }
      else{
        print("nall");
        Navigator.of(context).pushReplacementNamed('/onboarding');
      }
  }

  @override
  void initState(){
    super.initState();
    startTime();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width*1,
        decoration: BoxDecoration(
          color: kPrimaryColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 200),
          child: FadeAnimation(2,Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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

import 'package:easy_blood/animation/faceAnimation.dart';
import 'package:easy_blood/component/button_round.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/constant.dart';
import 'package:easy_blood/signin.dart';
import 'package:easy_blood/signup.dart';
import 'package:easy_blood/welcome/components/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Background(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeAnimation(
              1.4,
              Text(
                "WELCOME TO EASY BLOOD",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            FadeAnimation(
              1.4,
              Image.asset(
                "assets/images/welcome.png",
                height: size.height * 0.5,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ButtonRound(
              text: "SIGN IN",
              color: kPrimaryColor,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignIn();
                    },
                  ),
                );
              },
            ),
            ButtonRound(
              text: "SIGN UP",
              color: kPrimaryColor,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

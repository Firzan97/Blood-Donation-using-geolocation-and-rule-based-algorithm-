import 'package:easy_blood/animation/faceAnimation.dart';
import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 130,
            left: 70,
            child: FadeAnimation(1.7,Image.asset("assets/images/bloodicon.png"),),
          ),
          Positioned(
            top: 137,
            left: 70,
            child: Image.asset("assets/images/bloodiconwhite.png",scale: 1.3 ,),
          ),
          Positioned(
            top: 350,
            left: 20,
            child: FadeAnimation(1.7,Image.asset("assets/images/bloodicon.png"),),
          ),
          Positioned(
            top: 357,
            left: 20,
            child: Image.asset("assets/images/bloodiconwhite.png",scale: 1.3 ,),
          ),
          Positioned(
            top: 250,
            right: 150,
            child: FadeAnimation(1.7,Image.asset("assets/images/bloodicon.png"),),
          ),
          Positioned(
            top: 257,
            right: 160,
            child: Image.asset("assets/images/bloodiconwhite.png",scale: 1.3 ,),
          ),
          Positioned(
            top: 380,
            right: 0,
            child: FadeAnimation(1.7,Image.asset("assets/images/bloodicon.png"),),
          ),
          Positioned(
            top: 387,
            right: 10,
            child: Image.asset("assets/images/bloodiconwhite.png",scale: 1.3 ,),
          ),
          Positioned(
            top: 100,
            right: 60,
            child: FadeAnimation(1.7,Image.asset("assets/images/bloodicon.png"),),
          ),
          Positioned(
            top: 107,
            right: 70,
            child: Image.asset("assets/images/bloodiconwhite.png",scale: 1.3 ,),
          ),
        child,
        ],
      ),
    );
  }
}

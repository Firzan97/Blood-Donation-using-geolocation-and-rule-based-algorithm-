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
        color: kPrimaryColor,
      ),
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 130,
            left: 70,
            child: Image.asset("assets/images/bloodicon.png"),
          ),
          Positioned(
            top: 350,
            left: 20,
            child: Image.asset("assets/images/bloodicon.png"),
          ),
          Positioned(
            top: 250,
            right: 150,
            child: Image.asset("assets/images/bloodicon.png"),
          ),
          Positioned(
            top: 380,
            right: 0,
            child: Image.asset("assets/images/bloodicon.png"),
          ),
          Positioned(
            top: 100,
            right: 60,
            child: Image.asset("assets/images/bloodicon.png"),

          ),
        child,
        ],
      ),
    );
  }
}

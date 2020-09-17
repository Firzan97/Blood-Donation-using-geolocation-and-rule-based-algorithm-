import 'package:easy_blood/animation/faceAnimation.dart';
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
        child,
        ],
      ),
    );
  }
}

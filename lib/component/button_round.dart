import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';

class ButtonRound extends StatelessWidget {
  final String text;
  final Function press;
  final Color color,textColor;
  const ButtonRound({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor,
}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),

      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29.0),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 4.0),
          color: color,
          onPressed: press,
          child: Text(text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

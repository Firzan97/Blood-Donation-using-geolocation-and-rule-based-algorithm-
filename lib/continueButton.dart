import 'package:easy_blood/constant.dart';
import 'package:easy_blood/size.config.dart';
import 'package:flutter/material.dart';

class continueButton extends StatelessWidget {
  final Function press;
  final String text;

  const continueButton({
    this.text,
    this.press,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(text,style: TextStyle(fontSize: getProportionateScreenWidth(16),
            color: Colors.white),),
      ),
    );
  }
}

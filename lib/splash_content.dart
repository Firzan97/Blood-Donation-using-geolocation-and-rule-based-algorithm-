import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/constant.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/size.config.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    this.text,
    this.image,
    Key key,
  }) : super(key: key);
  final String text,image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text("EASY BLOOD",style: TextStyle(
            fontSize: getProportionateScreenWidth(36.00),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold
        ),),
        Text(text,textAlign: TextAlign.center,),
        Spacer(flex: 2,),
        Image.asset(image,
          height: getProportionateScreenHeight(300),
          width: getProportionateScreenWidth(350),)
      ],
    );
  }
}
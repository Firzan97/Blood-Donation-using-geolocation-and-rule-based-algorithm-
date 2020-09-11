import 'package:easy_blood/body.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/size.config.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(body: Body());
  }
}

import 'package:easy_blood/onboarding.dart';
import 'package:easy_blood/welcome/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(body: Body()));
  }


}

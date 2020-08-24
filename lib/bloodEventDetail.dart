import 'package:easy_blood/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BloodEventDetail extends StatelessWidget {
  final Event event;

  const BloodEventDetail({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          home: Scaffold(
            body: Container(
              child: Column(
                children: <Widget>[Text(event.name), Text(event.location)],
              ),
            ),
          ),
        ));
  }
}

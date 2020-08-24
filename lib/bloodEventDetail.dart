import 'package:easy_blood/model/event.dart';
import 'package:flutter/material.dart';

class BloodEventDetail extends StatelessWidget {
  final Event event;

  const BloodEventDetail({Key key, this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Text(event.name),
              Text(event.location)
            ],
          ),
        ),
      ),
    );
  }
}

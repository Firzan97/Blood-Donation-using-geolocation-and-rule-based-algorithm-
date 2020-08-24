import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ),
    child:MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[

            ],
          ),
        )
      ),
    )
    );
  }
}


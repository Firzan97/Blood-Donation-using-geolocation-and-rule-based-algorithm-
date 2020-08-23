import 'package:flutter/material.dart';

class BloodEvent extends StatefulWidget {
  @override
  _BloodEventState createState() => _BloodEventState();
}

class _BloodEventState extends State<BloodEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Add Blood Event"),
                    Text("BLOOD EVENT")
                  ],
                ),
                Text("Add Blood Event")
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

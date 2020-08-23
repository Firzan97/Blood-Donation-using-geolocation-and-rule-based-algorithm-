import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';

class BloodRequest extends StatefulWidget {
  @override
  _BloodRequestState createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height*0.1,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0))
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Center(child: Text("ABOUT")),
                      SizedBox(width: size.width*0.25,),
                      Text("BLOOD REQUEST"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[

              ],
            ),
          )
        ],
      ),
    );
  }
}

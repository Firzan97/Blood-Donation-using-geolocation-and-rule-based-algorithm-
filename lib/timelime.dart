import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ),
    child:Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0XFF343a69)
        ),
        child: Column(
          children: <Widget>[
            Row(
                 children: <Widget>[
                    Text("MY PROFILE"),
                 ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: size.height * 0.16,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/tonystark.jpg"),
                      )),
                ),
                Column(
                  children: <Widget>[
                    Text("Alext SuperTramp"),
                    Text("26 Tahun"),
                    Text("AB +")
                  ],
                )
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.08,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/bloodicon.png"),
                          )),
                    ),
                    Column(
                      children: <Widget>[
                        Text("1 Disember 2016"),
                        Text("PMI Kotagedhe"),
                        Text("2 kantong darah"),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    )
    );
  }
}

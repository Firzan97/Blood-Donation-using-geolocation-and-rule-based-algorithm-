import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height*0.3,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("Hai, Firzan Azrai"),
                            Text("Let's help people !")
                          ],
                        )
                      ],
                    ),
                    Row(),
                    Row()
                  ],
                ),
              decoration: BoxDecoration(
                  color: Color(0XFF343a69),
                borderRadius: BorderRadius.circular(15.0)
              ),),
              Container(
                child: Column(
                  children: <Widget>[
                    Row()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

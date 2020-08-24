import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
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
                          SizedBox(width: size.width*0.32,),
                          Center(child: Text("ABOUT")),
                        ],
                      ),
                    ),
                    Center(child: Text("VERSION 1"),)
                  ],
                ),
              ),
              SizedBox(height: size.height*0.05,),
              Container(
                child: Column(
                  children: <Widget>[
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children:[
                            TableCell(child: Center(child: Text("Who are we?")),)
                          ]
                        ),
                        TableRow(
                            children:[
                              TableCell(child: Center(child: Text("Why donate blood")),)
                            ]
                        ),
                        TableRow(
                            children:[
                              TableCell(child: Center(child: Text("Developer")),)
                            ]
                        )
                      ],
                    ),
                    SizedBox(height: 50.0),
                    Container(
                      height: size.height*0.5,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 0.5,
                            blurRadius: 7,
                            color: Colors.black.withOpacity(0.4)
                          )
                        ]
                      ),
                      child: Text("sasasaasasa"),
                    )
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

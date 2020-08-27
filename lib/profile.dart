import 'dart:ui';

import 'package:easy_blood/constant.dart';
import 'package:easy_blood/userdashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          home: Scaffold(
            body: Container(
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [kGradient1, kGradient2]),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 80.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  Container(
                                    height: size.height * 0.16,
                                    width: size.width * 0.23,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/images/tonystark.jpg"),
                                        )),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(left: 50,top:30,child: Image.asset("assets/images/profile.png",width: 70,)),
                    Positioned(
                      bottom: 10,
                      left: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 170,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [kGradient1, Colors.white70]),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                    blurRadius: 9,
                                    spreadRadius: 1
                                  )
                                ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Image.asset("assets/images/blood.png",
                                      width: 60),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("  55KG \n Weight")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 80,
                            width: 170,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end:  Alignment.topRight,
                                    colors: [kGradient1, Colors.white70]),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 9,
                                    spreadRadius: 1
                                )
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Image.asset("assets/images/blood.png",
                                      width: 60),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("  4 Times \n Donated")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                  Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text("Username"),
                              SizedBox(height: 5),
                              Text("FIRZANFX")
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text("Email"),
                              SizedBox(height: 5),

                              Text("fIRZANaZRAI97@GMAIL.COM")
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text("Blood Type"),
                              SizedBox(height: 5),

                              Text("AB")
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text("Age"),
                              SizedBox(height: 5),
                              Text("19")
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

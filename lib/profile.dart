import 'package:easy_blood/constant.dart';
import 'package:easy_blood/userdashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                              colors: [
//                            Color(0xffff5959),
                                kPrimaryColor,
                                Color(0xFFd50000),
                              ]),
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
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 210),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 170,
                            decoration: BoxDecoration(
                                color:  Colors.white,
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
                          Container(
                            height: 80,
                            width: 170,
                            decoration: BoxDecoration(
                                color:  Colors.white,
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
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}

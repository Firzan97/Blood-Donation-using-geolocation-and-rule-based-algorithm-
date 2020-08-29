import 'dart:async';

import 'package:easy_blood/about.dart';
import 'package:easy_blood/bloodEvent.dart';
import 'package:easy_blood/findRequest.dart';
import 'package:easy_blood/findRequest.dart';
import 'package:easy_blood/notification.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/profile.dart';
import 'package:easy_blood/requestBlood.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.32,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: size.height * 0.32,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
//                              Color(0xffff5959),
                              kPrimaryColor,
                              Color(0xFFd50000),
                            ]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              spreadRadius: 10,
                              blurRadius: 12),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 95,
                    right: 142,
                    child: Container(
                      height: size.height * 0.16,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/tonystark.jpg"),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BloodEvent()),
                            );
                          },
                        ),
                        SizedBox(width: size.width*0.30),
                        Text("DASHBOARD"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FindRequest()),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                        spreadRadius:1
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                height: 100.0,
                                width: 100.0,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 60.0),
                                    Text("Find Request"),
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 25,
                                  child:
                                  Image.asset("assets/images/findrequest.png")),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>RequestBlood()),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          spreadRadius:1
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 60.0),
                                    Text("Request Blood"),
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 24,
                                  child: Image.asset(
                                      "assets/images/requestblood.png")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BloodEvent()),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          spreadRadius:1
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 60.0),
                                    Text("Blood Event"),
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 25,
                                  child:
                                  Image.asset("assets/images/bloodevent.png")),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Profile()),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          spreadRadius:1,
                                      ),
                                    ],
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 60.0),
                                    Text("Profile"),
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 25,
                                  child: Image.asset("assets/images/profile.png")),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Notifications()),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          spreadRadius:1
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 60.0),
                                    Text("Notification"),
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 25,
                                  child:
                                  Image.asset("assets/images/notification.png")),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => About()),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 20,
                                        spreadRadius:1,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 60.0),
                                    Text("About"),
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 25,
                                  child: Image.asset("assets/images/about.png")),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, size.height-40);
    path.quadraticBezierTo(size.width/4, size.height
        - 40, size.width/2, size.height-20);
    path.quadraticBezierTo(3/4*size.width, size.height,
        size.width, size.height-80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return false;
  }
}

class MyClipper2 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path2 = Path();
    path2.lineTo(0, size.height-20);
    path2.quadraticBezierTo(size.width / 4, size.height
        - 40, size.width / 2, size.height - 20);
    path2.quadraticBezierTo(3 / 4 * size.width, size.height,
        size.width, size.height - 30);
    path2.lineTo(size.width, 0);
    return path2;

  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return false;
  }
  }

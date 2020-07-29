import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height*0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  spreadRadius: 1,
                  blurRadius: 12
                ),
              ],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60)),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "DASHBOARD",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Positioned(
                  top: 120,
                  right: 140,
                  child: Container(
                    height: size.height*0.18,
                    width: size.width*0.33,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/tonystark.jpg"),
                      )
                    ),
                  ),
                )
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
                      Stack(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text("Find Request"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text("Request Blood"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text("Blood Event"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text("Profile"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

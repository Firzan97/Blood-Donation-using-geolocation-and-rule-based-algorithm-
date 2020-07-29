import 'package:easy_blood/constant.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.3,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 120,
                  left: 70,
                  child: Container(
                    width: size.width*0.7,
                    height: 150,
                    decoration: BoxDecoration(
                        color: kSecondaryColor
                    ),
                    child: Text("sasas"),
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 12),
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: size.width*0.36,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "DASHBOARD",
                        style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 95,
                  right: 140,
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width * 0.30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/tonystark.jpg"),
                        )),
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
                      Stack(
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
                      Stack(
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
                      Stack(
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
                      Stack(
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

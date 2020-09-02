import 'package:easy_blood/constant.dart';
import 'package:easy_blood/home.dart';
import 'package:easy_blood/userdashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Stack(children: <Widget>[
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          height: size.height * 0.41,
                          width: size.width * 1,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    left: 0,
                                    top: 10,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                      left: 191, top: 25, child: Text("ABOUT")),
                                  Positioned(
                                      top: 60,
                                      left: 100,
                                      child: Image.asset(
                                        "assets/images/bloodcell2.png",
                                        width: 200,
                                      )),
                                ]),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[],
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Color(0xffffbcaf), kGradient2]),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 1,
                        width: size.width * 1,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: size.height * 0.3),
                            Container(
                              width: size.width * 0.7,
                              height: size.height * 0.28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              color: Colors.black
                                                  .withOpacity(0.05))
                                        ]),
                                    height: 40,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                      ),
                                        color: Colors.white,
                                        onPressed: () {},
                                        child:
                                            Center(child: Text("Who are we?"))),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,

                                    ),
                                    height: 40,
                                    child: FlatButton(
                                        color: Colors.white,
                                        onPressed: () {},
                                        child: Center(
                                            child: Text("Why donate blood?"))),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                    ),
                                    height: 40,
                                    child: FlatButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          infoDialog(context);
                                        },
                                        child:
                                            Center(child: Text("Developer"))),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),

                                    ),
                                    height: 40,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),

                                      ),
                                        color: Colors.white,
                                        onPressed: () {},
                                        child: Center(child: Text("Version"))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool> infoDialog(context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("DEVELOPER"),
          content: Text("Final Year Student"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}

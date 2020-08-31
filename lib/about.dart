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
                      Container(
                        height: size.height * 1,
                        width: size.width * 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [kGradient1, kGradient2]),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: size.height * 0.5),
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
                                        border: Border(
                                            bottom: BorderSide(
                                                color: kPrimaryColor,
                                                width: 1)),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              color: Colors.black
                                                  .withOpacity(0.05))
                                        ]),
                                    height: 40,
                                    child: FlatButton(
                                        color: Colors.white,
                                        onPressed: () {},
                                        child:
                                            Center(child: Text("Who are we?"))),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: kPrimaryColor, width: 1)),
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
                                      border: Border(
                                          bottom: BorderSide(
                                              color: kPrimaryColor, width: 1)),
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
                                      border: Border(
                                          bottom: BorderSide(
                                              color: kPrimaryColor, width: 1)),
                                    ),
                                    height: 40,
                                    child: FlatButton(
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
                                        "assets/images/humaaans.png",
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
                                colors: [kGradient1, kGradient2]),
                          ),
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

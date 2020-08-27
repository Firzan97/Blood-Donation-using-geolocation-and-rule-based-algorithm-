import 'package:easy_blood/constant.dart';
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
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      padding: EdgeInsets.only(left: 40, top: 50, right: 20),
                      height: size.height * 0.41,
                      width: size.width*1,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Stack(children: <Widget>[
                              Positioned(left: size.width*0.37,child: Text("ABOUT")),
                              Positioned(top:20,left: 60,child: Image.asset("assets/images/humaaans.png",width: 200,)),

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
                  Container(
                    width: size.width*0.7,
                    height: size.height*0.28,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white70,

                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.05)
                              )
                            ]
                          ),
                          height: 40,
                          child: FlatButton(

                              onPressed: () {},
                              child: Center(child: Text("Who are we?"))),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white70,


                          ),
                          height: 40,
                          child: FlatButton(

                              onPressed: () {},
                              child: Center(child: Text("Why donate blood?"))),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white70,

                          ),
                          height: 40,
                          child: FlatButton(
                              onPressed: () {},
                              child: Center(child: Text("Developer"))),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white70,

                          ),
                          height: 40,
                          child: FlatButton(
                              onPressed: () {},
                              child: Center(child: Text("Version"))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height*0.02,),
                  Container(
                    height: size.height * 0.2,
                    width: size.width * 0.8,
                    decoration:
                    BoxDecoration(color: kPrimaryColor, boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.5,
                          blurRadius: 7,
                          color: Colors.black.withOpacity(0.4))
                    ]),
                    child: Text("sasasaasasa"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

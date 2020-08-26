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
              child: Column(
                children: <Widget>[
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: size.height * 0.41,
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text("ABOUT"),
                          )),
                          SizedBox(height: 120,),
                          Text("Version 1.1",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
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
                    child: Column(
                      children: <Widget>[
                        Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(children: [
                              TableCell(
                                child: Center(child: Text("Who are we?")),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(child: Text("Why donate blood")),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(child: Text("Developer")),
                              )
                            ])
                          ],
                        ),
                        SizedBox(height: 50.0),
                        Container(
                          height: size.height * 0.3,
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
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

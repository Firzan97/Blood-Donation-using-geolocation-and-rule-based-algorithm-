import 'package:easy_blood/constant.dart';
import 'package:easy_blood/signin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class RequestBlood extends StatefulWidget {
  @override
  _RequestBloodState createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  TextEditingController location = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
        home: Scaffold(
            body: Container(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [kGradient1, kGradient2]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 35.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "I need blood .. ",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      FaIcon(FontAwesomeIcons.sadCry)
                    ],
                  ),
                  SizedBox(height: size.height*0.01,),
                  Form(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height:28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                          color: Colors.white, shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.location_on,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Your location",
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: location,

                                ),

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height:28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                          color: Colors.white, shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.group_work,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Blood Group",
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: location,
                                ),

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height:28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                          color: Colors.white, shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.whatshot,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "How many bag ?",
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                TextFormField(
                                  controller: location,
                                ),

                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height:28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                        color: Colors.white, shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.help,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Reason",
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              TextFormField(
                                controller: location,
                              ),

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
          Container(),
        ],
      ),
    )));
  }
}

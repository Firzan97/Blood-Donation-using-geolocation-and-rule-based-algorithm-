import 'dart:ui';

import 'package:easy_blood/constant.dart';
import 'package:easy_blood/home.dart';
import 'package:easy_blood/userdashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                Container(
                  height: size.height*1,
                  child: Stack(
                    children: <Widget>[
                      ClipPath(
                        clipper: MyClipper2(),
                        child: Container(
                          height: size.height * 0.42,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [kGradient2, kGradient1]),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              spreadRadius: 3,
                              color: Colors.black.withOpacity(0.9)
                            )
                          ]),
                        ),
                      ),
                      Opacity(
                        opacity: 0.9,
                        child: Container(
                          height: size.height*0.7,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [kGradient1, kGradient2]),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (){
                                      Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      );
                                    },
                                    icon: Icon(Icons.arrow_back,color: Colors.white,),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.menu,color: Colors.white,),
                                  )
                                ],
                              ),
                              ListTile(
                                leading: Container(
                                  width: 55,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/images/lari2.jpg")
                                    )
                                  ),
                                ),
                                title: Text("Firzan Azrai"),
                                subtitle: Text("Joined 3 days ago"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.location_on),
                                          Text("Tumpat, Kelantan")
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: kPrimaryColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 12
                                          )
                                        ]
                                      ),
                                      child: FlatButton(
                                        onPressed: (){

                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Text("AB+"),
                                        )),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                     color: kGradient1,
                                    boxShadow: [BoxShadow(
                                      blurRadius: 9,
                                      spreadRadius: 3,
                                      color: Colors.black.withOpacity(0.1)
                                    )],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Text("4"),
                                              Text("Blood donated")
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text("4"),
                                            Text("Blood Requested")
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text("Status"),
                                            Text("Eligible to donate")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width * 1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(19.0),
                                  child: Container(
                                    height: size.height*0.3,
                                    width: size.width * 1,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 3,
                                          blurRadius: 12
                                        )
                                      ]
                                        ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(5),
                                                      child: Image.asset(
                                                          "assets/images/lari2.jpg",fit: BoxFit.cover,)),
                                                ),
                                                SizedBox(width: size.width*0.09,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("6 hours ago"),
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text("Syazwan Asraf"),
                                                        ),
                                                        SizedBox(width: size.width*0.08,),
                                                        Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <Widget>[
                                                                  Icon(Icons.thumb_up),
                                                                  Text("1")
                                                                ],
                                                              ),
                                                              SizedBox(width: size.width*0.05,),
                                                              Row(
                                                                children: <Widget>[
                                                                  Icon(Icons.comment),
                                                                  Text("1")
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      child: Image.asset(
                                                        "assets/images/lari2.jpg",fit: BoxFit.cover,)),
                                                ),
                                                SizedBox(width: size.width*0.09,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("6 hours ago"),
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text("Syazwan Asraf"),
                                                        ),
                                                        SizedBox(width: size.width*0.08,),
                                                        Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <Widget>[
                                                                  Icon(Icons.thumb_up),
                                                                  Text("1")
                                                                ],
                                                              ),
                                                              SizedBox(width: size.width*0.05,),
                                                              Row(
                                                                children: <Widget>[
                                                                  Icon(Icons.comment),
                                                                  Text("1")
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(19.0),
                                  child: Container(
                                    height: size.height*0.3,
                                    width: size.width * 1,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 3,
                                              blurRadius: 12
                                          )
                                        ]
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      child: Image.asset(
                                                        "assets/images/lari2.jpg",fit: BoxFit.cover,)),
                                                ),
                                                SizedBox(width: size.width*0.09,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("6 hours ago"),
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text("Syazwan Asraf"),
                                                        ),
                                                        SizedBox(width: size.width*0.08,),
                                                        Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <Widget>[
                                                                  Icon(Icons.thumb_up),
                                                                  Text("1")
                                                                ],
                                                              ),
                                                              SizedBox(width: size.width*0.05,),
                                                              Row(
                                                                children: <Widget>[
                                                                  Icon(Icons.comment),
                                                                  Text("1")
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      child: Image.asset(
                                                        "assets/images/lari2.jpg",fit: BoxFit.cover,)),
                                                ),
                                                SizedBox(width: size.width*0.09,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("6 hours ago"),
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text("Syazwan Asraf"),
                                                        ),
                                                        SizedBox(width: size.width*0.08,),
                                                        Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <Widget>[
                                                                  Icon(Icons.thumb_up),
                                                                  Text("1")
                                                                ],
                                                              ),
                                                              SizedBox(width: size.width*0.05,),
                                                              Row(
                                                                children: <Widget>[
                                                                  Icon(Icons.comment),
                                                                  Text("1")
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
         )
        )
    );
  }
}

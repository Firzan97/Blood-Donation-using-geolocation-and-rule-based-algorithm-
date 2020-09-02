import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_blood/about.dart';
import 'package:easy_blood/animation/faceAnimation.dart';
import 'package:easy_blood/bloodEvent.dart';
import 'package:easy_blood/blood_request.dart';
import 'package:easy_blood/component/curvedBackground.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/notification.dart';
import 'package:easy_blood/profile.dart';
import 'package:easy_blood/requestBlood.dart';
import 'package:easy_blood/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  String name;
  var data ;


  void getUserData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
     setState(() {
       name= localStorage.getString("user");
       data = jsonDecode(name);
     });
    print(data);}

  @override
  void initState(){
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return   WillPopScope(
      onWillPop: _onBackPressed,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: MaterialApp(
            theme: ThemeData(primaryColor: kPrimaryColor),
            debugShowCheckedModeBanner: false,
            home: data==null ? LoadingScreen() : Scaffold(
              drawer: Container(
                width: 340,
                child: Drawer(
                  child: Container(
                    color: Colors.white24,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Container(
                          child: UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [kGradient1, kGradient2]),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 13)
                                ]),
                            accountName: data['username']==null ? Text("Loading") : Text(data['username'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            accountEmail: Text(
                              data["email"],
                              style: TextStyle(fontSize: 11, color: Colors.black),
                            ),
                            currentAccountPicture: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage("assets/images/tonystark.jpg")),
                          ),
                        ),
                        FadeAnimation(
                            0.5,
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 13, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7
                                      )
                                    ]),
                                height: 50,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  disabledColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Profile"),
                                      Icon(
                                        Icons.person,
                                        color: kPrimaryColor,
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()),
                                    );
                                  },
                                ),
                              ),
                            )),
                        FadeAnimation(
                            0.5,
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 13, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7
                                      )
                                    ]),
                                height: 50,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  disabledColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Request Blood"),
                                      FaIcon(
                                        FontAwesomeIcons.handsHelping,
                                        color: kPrimaryColor,
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    getUserData();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RequestBlood()),
                                    );
                                  },
                                ),
                              ),
                            )),
                        FadeAnimation(
                            0.5,
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 13, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7
                                      )
                                    ]),
                                height: 50,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  disabledColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Find Request"),
                                      Icon(
                                        Icons.find_in_page,
                                        color: kPrimaryColor,
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BloodRequest()),
                                    );
                                  },
                                ),
                              ),
                            )),
                        FadeAnimation(
                            0.5,
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 13, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7
                                      )
                                    ]),
                                height: 50,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                  ),
                                  disabledColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Blood Event"),
                                      Icon(
                                        Icons.event,
                                        color: kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BloodEvent()),
                                    );
                                  },
                                ),
                              ),
                            )),
                        FadeAnimation(
                            0.5,
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 13, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7
                                      )
                                    ]),
                                height: 50,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  disabledColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Notification"),
                                      FaIcon(
                                        FontAwesomeIcons.bell,
                                        color: kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Notifications()),
                                    );
                                  },
                                ),
                              ),
                            )),
                        FadeAnimation(
                            0.5,
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 13, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7
                                      )
                                    ]
                                ),
                                height: 50,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  disabledColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("About"),
                                      FaIcon(
                                        FontAwesomeIcons.info,
                                        color: kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => About()),
                                    );
                                  },
                                ),
                              ),
                            )),
                        FadeAnimation(
                            0.5,
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 13, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 7
                                  )
                                ]),
                                height: 50,
                                child: FlatButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Log Out"),
                                      FaIcon(
                                        FontAwesomeIcons.doorOpen,
                                        color: kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    LogOutDialog(context);
                                  },
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: CurvedNavigationBar(
                key: _bottomNavigationKey,
                index: 0,
                height: 50.0,
                items: <Widget>[
                  Icon(Icons.add, size: 30,color: Colors.black,),
                  Icon(Icons.list, size: 30,color: Colors.black),
                  Icon(Icons.compare_arrows, size: 30,color: Colors.black),
                  Icon(Icons.call_split, size: 30,color: Colors.black),
                  Icon(Icons.perm_identity, size: 30,color: Colors.black),
                ],
                color: Colors.white,
                buttonBackgroundColor: kPrimaryColor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ,
                backgroundColor: Colors.white,
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 400),
                onTap: (index) {
                  setState(() {
                    _page = index;

                  });
                },
              ),
              body: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Stack(children: <Widget>[

                      ClipPath(
                        clipper: MyClipper2(),
                        child: Container(
                          height: size.height * 0.39,
                          decoration: BoxDecoration(color: kGradient1),
                        ),
                      ),
                      Positioned(
                          right:40,
                          top:20,
                          child: Image.asset("assets/images/bloodcell.png",scale: 3,)),
                      Positioned(
                        right:225,
                        top:130,
                        child: Image.asset("assets/images/bloodcell.png",scale: 5,),
                      ),
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          height: size.height * 0.39,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                          text: TextSpan(
                                            text: 'Hai, ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 18.0),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: data['username'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kThirdColor)),
                                            ],
                                          ),
                                        ),

                                        Text(
                                          "Let's save people's life !",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              letterSpacing: 1,
                                              wordSpacing: 2),
                                        )
                                      ],
                                    ),
                                    IconButton(
                                      iconSize: 25.0,
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Notifications()),
                                        );
                                      },hoverColor: Colors.red,
                                      splashColor: Colors.black,
                                      icon: Icon(Icons.notifications,color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: size.height * 0.07,
                                      width: size.width * 0.7,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(11.00)),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.location_on,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text("Locate your location")
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: Colors.lightBlue,
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.library_books),
                                          SizedBox(
                                            width: size.width * 0.03,
                                          ),
                                          Text("Blood Type."),
                                          data["bloodType"]==null ? Text("None", style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),) : Text(
                                            data["bloodType"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Text("Age."),
                                          Text(
                                            '${data["age"]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Text("Weight."),
                                          Text(
                                            "55KG",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            height: 40.0,
                                            width: 40.0,
                                            child: Icon(Icons.search),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            height: 40.0,
                                            width: 40.0,
                                            child: Icon(Icons.search),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            height: 40.0,
                                            width: 40.0,
                                            child: Icon(Icons.event),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [kGradient1.withOpacity(0.7), kGradient2.withOpacity(0.7)]),
                          ),
                        ),
                      ),
                    ]),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Container(
                                 decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(9),
                                     boxShadow: [
                                       BoxShadow(
                                           color: Colors.grey.withOpacity(0.15),
                                           spreadRadius: 10,
                                           blurRadius: 10
                                       )
                                     ]
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Column(
                                     children: <Widget>[
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: <Widget>[
                                           Text("New Blood Campaign",style: TextStyle(
                                               fontWeight: FontWeight.w400
                                           ),),
                                           Text("See All")
                                         ],
                                       ),
                                       Container(

                                         child: Row(
                                           children: <Widget>[
                                             Container(
                                               width: 120,
                                               height: 170,
                                               child: Stack(
                                                 children: <Widget>[
                                                   Positioned(
                                                     bottom: 0,
                                                     left: 5,
                                                     child: Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Container(
                                                         height: 130,
                                                         width: 100,
                                                         decoration: BoxDecoration(
                                                           borderRadius:
                                                           BorderRadius.circular(20.0),
                                                           color: kGradient1,
                                                           boxShadow: [
                                                             BoxShadow(
                                                               color: Colors.grey.withOpacity(0.15),
                                                               blurRadius: 5,
                                                               spreadRadius: 3
                                                             )
                                                           ]
                                                         ),
                                                         child: Column(
                                                           children: <Widget>[
                                                             SizedBox(
                                                               height: 110.0,
                                                             ),
                                                             Text(
                                                               "17/8/2020",
                                                               style: TextStyle(
                                                                   color: Colors.black),
                                                             )
                                                           ],
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                   Padding(
                                                     padding: const EdgeInsets.all(8.0),
                                                     child: Container(
                                                       decoration: BoxDecoration(
                                                           borderRadius:
                                                           BorderRadius.circular(20.0),
                                                           boxShadow: [
                                                             BoxShadow(
                                                                 spreadRadius: 4,
                                                                 color: Colors.black
                                                                     .withOpacity(0.1),
                                                                 blurRadius: 5)
                                                           ]),
                                                       child: ClipRRect(
                                                           borderRadius:
                                                           BorderRadius.circular(20.0),
                                                           child: Image.asset(
                                                             "assets/images/dermadarah1.jpg",
                                                             width: 100,
                                                           )),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             Container(
                                               width: 120,
                                               height: 170,
                                               child: Stack(
                                                 children: <Widget>[
                                                   Positioned(
                                                     bottom: 0,
                                                     left: 5,
                                                     child: Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Container(
                                                         height: 130,
                                                         width: 100,
                                                         decoration: BoxDecoration(
                                                           borderRadius:
                                                           BorderRadius.circular(20.0),
                                                           color: kPrimaryColor,
                                                             boxShadow: [
                                                               BoxShadow(
                                                                   color: Colors.black.withOpacity(0.1),
                                                                   blurRadius: 5,
                                                                   spreadRadius: 3
                                                               )
                                                             ]
                                                         ),
                                                         child: Column(
                                                           children: <Widget>[
                                                             SizedBox(
                                                               height: 110.0,
                                                             ),
                                                             Text(
                                                               "17/8/2020",
                                                               style: TextStyle(
                                                                   color: Colors.white,
                                                               fontWeight: FontWeight.w400),
                                                             )
                                                           ],
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                   Padding(
                                                     padding: const EdgeInsets.all(8.0),
                                                     child: Container(
                                                       decoration: BoxDecoration(
                                                           borderRadius:
                                                           BorderRadius.circular(20.0),
                                                           boxShadow: [
                                                             BoxShadow(
                                                                 spreadRadius: 4,
                                                                 color: Colors.black
                                                                     .withOpacity(0.1),
                                                                 blurRadius: 5)
                                                           ]),
                                                       child: ClipRRect(
                                                           borderRadius:
                                                           BorderRadius.circular(20.0),
                                                           child: Image.asset(
                                                             "assets/images/dermadarah1.jpg",
                                                             width: 100,
                                                           )),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             Container(
                                               width: 130,
                                               height: 170,
                                               child: Stack(
                                                 children: <Widget>[
                                                   Positioned(
                                                     bottom: 0,
                                                     left: 5,
                                                     child: Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Container(
                                                         height: 130,
                                                         width: 100,
                                                         decoration: BoxDecoration(
                                                           borderRadius:
                                                           BorderRadius.circular(20.0),
                                                           color: kThirdColor,
                                                         ),
                                                         child: Column(
                                                           children: <Widget>[
                                                             SizedBox(
                                                               height: 110.0,
                                                             ),
                                                             Text(
                                                               "17/8/2020",
                                                               style: TextStyle(
                                                                   color: Colors.white),
                                                             )
                                                           ],
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                   Padding(
                                                     padding: const EdgeInsets.all(8.0),
                                                     child: Container(
                                                       decoration: BoxDecoration(
                                                           borderRadius:
                                                           BorderRadius.circular(20.0),
                                                           boxShadow: [
                                                             BoxShadow(
                                                                 spreadRadius: 4,
                                                                 color: Colors.black
                                                                     .withOpacity(0.1),
                                                                 blurRadius: 5)
                                                           ]),
                                                       child: ClipRRect(
                                                           borderRadius:
                                                           BorderRadius.circular(20.0),
                                                           child: Image.asset(
                                                             "assets/images/dermadarah1.jpg",
                                                             width: 100,
                                                           )),
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
                               ),
                             ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Blood Request"),
                                            Text("See All")
                                          ],
                                        ),
                                      ),
                                      Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ListTile(
                                                  dense: true,
                                                  leading: Container(
                                                    height: size.height * 0.149,
                                                    width: size.width * 0.15,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              "assets/images/lari2.jpg"),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(5)),
                                                  ),
                                                  title: Text(
                                                    "Syazwan Asraf",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 17),
                                                  ),
                                                  subtitle: Text(
                                                    "Posted: 3 hours ago",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w300),
                                                  ),
                                                  trailing: Text(
                                                    "AB+",
                                                    style:
                                                        TextStyle(color: kPrimaryColor),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          )),
                                      Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ListTile(
                                                  dense: true,
                                                  leading: Container(
                                                    height: size.height * 0.149,
                                                    width: size.width * 0.15,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              "assets/images/lari2.jpg"),
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                  ),
                                                  title: Text(
                                                    "Syazwan Asraf",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 17),
                                                  ),
                                                  subtitle: Text(
                                                    "Posted: 3 hours ago",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w300),
                                                  ),
                                                  trailing: Text(
                                                    "AB+",
                                                    style:
                                                    TextStyle(color: kPrimaryColor),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          )),
                                      Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ListTile(
                                                  dense: true,
                                                  leading: Container(
                                                    height: size.height * 0.149,
                                                    width: size.width * 0.15,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              "assets/images/lari2.jpg"),
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                  ),
                                                  title: Text(
                                                    "Syazwan Asraf",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 17),
                                                  ),
                                                  subtitle: Text(
                                                    "Posted: 3 hours ago",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w300),
                                                  ),
                                                  trailing: Text(
                                                    "AB+",
                                                    style:
                                                    TextStyle(color: kPrimaryColor),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ))
                                    ],
                                  ),
                                ),

                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

void getPosition() async {
  Position position = await Geolocator()
      .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  print(position.accuracy);
  print(position.longitude);
  print("nate");
}

void LogOut() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("user", null);
  var email2=pref.getString("userEmail");
  print(email2);
}

Future<bool> _onBackPressed(){
  return SystemNavigator.pop();
}

Future<bool> LogOutDialog(context){
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Alert!"),
          content: Text("Are you sure want to Logout?"),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: (){
                LogOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Welcome()),
                );
              },
            ),
          ],
        );
      }
  );
}
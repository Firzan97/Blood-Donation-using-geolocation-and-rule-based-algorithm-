import 'dart:convert';
import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_blood/about/about.dart';
import 'package:easy_blood/animation/faceAnimation.dart';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/curvedBackground.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/event/bloodEvent.dart';
import 'package:easy_blood/event/bloodEventDetail.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/event.dart';
import 'package:easy_blood/model/request.dart';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/notification.dart';
import 'package:easy_blood/profile/edit_profile.dart';
import 'package:easy_blood/profile/profile.dart';
import 'package:easy_blood/request/blood_request.dart';
import 'package:easy_blood/requestBlood.dart';
import 'package:easy_blood/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  String name;
  var user ;
  Future<List<Event>> _futureEvent;
  Future<List<Requestor>> _futureRequest;
  bool profileUpdate=false;
  List<User> a = [];
  bool statusUpdated;
   var token;

  void getUserData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
     setState(() {
       user= jsonDecode(localStorage.getString("user"));
       statusUpdated=localStorage.getBool('statusUpdated');
       token = localStorage.getString('tokenNotification');
     });
     print(statusUpdated);
    print(user);
    print(token);
  }


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
            theme: ThemeData(primaryColor: kPrimaryColor,
            fontFamily: "Muli"),
            debugShowCheckedModeBanner: false,
            home:  user==null ? LoadingScreen() : Scaffold(
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
                              image: DecorationImage(
                                image: AssetImage("assets/images/bloodcell.png"),
                              ),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xffffbcaf),
                                      kGradient2.withOpacity(0.9)
                                    ]),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 13)
                                ]),
                            accountName: user['username']==null ? Text("Loading") : Text(user['username'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            accountEmail: Text(
                              user["email"],
                              style: TextStyle(fontSize: 11, color: Colors.black),
                            ),
                            currentAccountPicture: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: user['imageURL']==null
                                    ? AssetImage("assets/images/profile.png")
                                    : NetworkImage(user['imageURL'])),
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
                                                  text: user['username'],
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
                                          user["bloodType"]==null ? Text("None", style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),) : Text(
                                            user["bloodType"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Text("Age."),
                                          Text(
                                            '${user["age"]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Text("Weight."),

                                          Text(
                                            user["weight"]==null ? "None" : user["weight"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
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
                      statusUpdated==true ? Positioned(
                        bottom:5,
                        right: 70,
                        child: Container(
                          height: 55,
                          width: 270,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.yellow
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("Your profile is not updated yet. \n Please update your profile!",style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Muli",
                                    color: Colors.black,
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ) : Container()
                    ]),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: size.height*0.02,),
                             Container(
                               height: size.height*0.33,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(20),

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
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: <Widget>[
                                         Text("New Campaign",style: TextStyle(
                                             fontWeight: FontWeight.w700),
                                              ),
                                              GestureDetector(
                                                child: Text("See All",style: TextStyle(
                                                    fontWeight: FontWeight.w700),),
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => BloodEvent()),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                   ),
                                        FutureBuilder(
                                            future: fetchEvent(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data == null) {

                                                return Container(
                                                  height: 170,
                                                  width: size.width*0.9,
                                                  child: Center(
                                                    child: LoadingScreen(),
                                                  ),
                                                );
                                              }
                                              else if(snapshot.data.length==0){
                                                return Container(
                                                  height: 170,
                                                  width: size.width*0.9,
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/images/nodata.png"
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 200,
                                                      width: size.width*0.9999,
                                           child:  ListView.builder(
                                                 shrinkWrap: true,
                                               scrollDirection: Axis.horizontal,
                                               itemCount: snapshot.data.length,
                                               itemBuilder: (BuildContext context, int index){
                                                 DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                                                 String dateStart = dateFormat.format(snapshot.data[index].timeStart);
                                                 dynamic currentTime = DateFormat.jm().format(snapshot.data[index].timeStart);

                                                            return GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          BloodEventDetail(
                                                                              event: snapshot.data[index])),
                                                                );
                                                              },
                                                              child: Container(
                                                                width: 260,
                                                                child: Stack(
                                                                  children: <
                                                                      Widget>[
                                                                    Positioned(
                                                                      bottom:
                                                                      22,
                                                                      left: 47,
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.all(8.0),
                                                                        child: Container(
                                                                          height: size.height*0.23,
                                                                          width: 200,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                              color: kPrimaryColor,
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                    color: Colors.grey.withOpacity(0.15),
                                                                                    blurRadius: 5,
                                                                                    spreadRadius: 3,
                                                                                    offset: Offset(0.1, 0.2)
                                                                                )
                                                                              ]
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.only(left: 80.0),
                                                                            child: Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Text(snapshot.data[index].name,style: TextStyle(
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w700
                                                                                ),),
                                                                                Text("Date"),
                                                                                Text(
                                                                                  dateStart,
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 12,),
                                                                                ),Text(
                                                                                  currentTime,
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 12,),
                                                                                ),
                                                                                Text(
                                                                                  snapshot.data[index].location,
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 12,),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom:
                                                                          15,
                                                                      left: 40,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                             child: Container(
                                                                 height: size.height*0.23,
                                                               width: 200,
                                                               decoration: BoxDecoration(
                                                                   borderRadius:
                                                                   BorderRadius.circular(10.0),
                                                                   color: Colors.white,
                                                                   boxShadow: [
                                                                     BoxShadow(
                                                                         color: Colors.grey.withOpacity(0.15),
                                                                         blurRadius: 5,
                                                                         spreadRadius: 3,
                                                                         offset: Offset(0.1, 0.2)
                                                                     )
                                                                   ]
                                                               ),
                                                               child: Padding(
                                                                 padding: const EdgeInsets.only(left: 80.0),
                                                                 child: Column(
                                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                   children: <Widget>[
                                                                     Text(snapshot.data[index].name,style: TextStyle(
                                                                         fontSize: 14,
                                                                         fontWeight: FontWeight.w700
                                                                     ),),
                                                                     Text("Date"),
                                                                     Text(
                                                                       dateStart,
                                                                       style: TextStyle(
                                                                         color: Colors.black,
                                                                         fontSize: 12,),
                                                                     ),Text(
                                                                       currentTime,
                                                                       style: TextStyle(
                                                                         color: Colors.black,
                                                                         fontSize: 12,),
                                                                     ),
                                                                     Text(
                                                                       snapshot.data[index].location,
                                                                       style: TextStyle(
                                                                         color: Colors.black,
                                                                         fontSize: 12,),
                                                                     ),
                                                                   ],
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                         ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(10.0),
                                                                      child: Container(
                                                                        width: 100,
                                                                        height: 140,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                            color: kPrimaryColor,
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                  spreadRadius: 4,
                                                                                  color: Colors.grey
                                                                                      .withOpacity(0.1),
                                                                                  blurRadius: 2)
                                                                            ]),
                                                                      ),
                                                                    ),
                                                         Padding(
                                                           padding: const EdgeInsets.all(16.0),
                                                           child: Container(
                                                             height: size.height*0.20,
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
                                                                 BorderRadius.circular(10.0),
                                                                 child: Image.network(
                                                                   snapshot.data[index].imageURL,
                                                                   width: 100,
                                                                   height: 200,
                                                                   fit: BoxFit.fill,
                                                                 )),
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                 );
                                               }),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                      ]),
                             ),
                              SizedBox(height: size.height*0.03,),

                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                        height: size.height*0.33,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 3,
                                                  blurRadius: 12)
                                            ]),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Recent Requests",style: TextStyle(
                                                fontWeight: FontWeight.w700),),
                                            Text("See All",style: TextStyle(
                                                fontWeight: FontWeight.w700),)
                                          ],
                                        ),
                                      ),
                                      FutureBuilder(
                                        future: fetchBlood(),
                                        builder: (BuildContext context,AsyncSnapshot snapshot){
                                          if(!snapshot.hasData){
                                            return Container(
                                              height:size.height*0.27,
                                              child: Center(
                                                child: LoadingScreen(),
                                              ),
                                            );
                                          }
                                          else if(snapshot.data.length==0){
                                            return Container(
                                              height: 170,
                                              width: size.width*0.9,
                                              child: Center(
                                                child: Image.asset(
                                                    "assets/images/nodata.png"
                                                ),
                                              ),
                                            );
                                          }
                                        return  Container(
                                          height:size.height*0.27,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                             itemCount: snapshot.data.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                DateTime dateTime = DateTime.parse(snapshot.data[index].created_at);
                                                DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                                                String time = dateFormat.format(dateTime);

                                              return Column(
                                                children: <Widget>[
                                                  Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  height: size.height * 0.08,
                                                                  width: size.width * 0.18,
                                                                  decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image: NetworkImage(
                                                                          a[index].imageURL,),
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius.circular(2)),
                                                                ),
                                                                SizedBox(width: size.width*0.03,),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      a[index].username,
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 14),
                                                                    ),
                                                                    Text(
                                                                      snapshot.data[index].location,
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 13),
                                                                    ),
                                                                    Text(
                                                                      Jiffy(time).fromNow() // 7 years ago
                                                                      ,
                                                                      style: TextStyle(
                                                                          color: Colors.grey,
                                                                          fontSize: 10,
                                                                          fontWeight: FontWeight.w300),
                                                                    ),
                                                                  ],
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            snapshot.data[index].bloodType,
                                                            style:
                                                            TextStyle(color: kPrimaryColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );}
                                            ));},
                                      )
                                      ],
                                    ),
                                  ),
                              ),
                              SizedBox(height: size.height*0.03,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: size.width*1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                     borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 3,
                                        blurRadius: 9
                                      )
                                    ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ClipOval(
                                              child: Material(
                                                color: kPrimaryColor, // button color
                                                child: InkWell(
                                                  splashColor: Colors.black, // inkwell color
                                                  child: SizedBox(width: 36, height: 36, child: Icon(Icons.share)),
                                                  onTap: () {
                                                  },
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Invite Your Friends",style: TextStyle(
                                                    fontWeight: FontWeight.w700
                                                ),),
                                                Text("Inviting more people to become the life savior, \nit could be someone that you know.",style: TextStyle(
                                                  fontWeight: FontWeight.w500
                                                ),)
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(),
                                            Container(
                                              child: FlatButton(
                                                onPressed: (){

                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.arrow_forward_ios,size: 15,),
                                                    Text("Invite")
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
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
                    )
                  ],
                ),
              ),
            ),
          )),
    );

  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Do you want to exit the App'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); //Will not exit the App
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true); //Will exit the App
              },
            )
          ],
        );
      },
    ) ?? false;
  }


  Future<List<Event>> fetchEvent() async {

    var res = await Api().getData("event");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Event> events = [];
      for (Map u in body) {
        Event event = Event.fromJson(u);
        events.add(event);
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Requestor>> fetchBlood() async {
    var res = await Api().getData("request");
    var bodys = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Requestor> requests = [];
      for (Map u in bodys) {
        Requestor req = Requestor.fromJson(u);
        User user = req.user;
        a.add(user);
        requests.add(req);
      }

      return requests;
    } else {
      throw Exception('Failed to load album');
    }
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

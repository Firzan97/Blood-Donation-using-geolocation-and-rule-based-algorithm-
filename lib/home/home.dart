import 'dart:convert';
import 'dart:async';

import 'package:easy_blood/about/about.dart';
import 'package:easy_blood/animation/faceAnimation.dart';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/chat/chat_home.dart';
import 'package:easy_blood/component/curvedBackground.dart';
import 'package:easy_blood/component/custom_dialog_notification.dart';
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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:easy_blood/achievement/achievementHome.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var lastdonate="0";
  int _page = 0;
  List<Color> colorList = [Colors.black,Colors.black,Colors.black,Colors.black,Colors.black];
  GlobalKey _bottomNavigationKey = GlobalKey();
  String name;
  var user ;
  Future<List<Event>> _futureEvent;
  Future<List<Requestor>> _futureRequest;
  bool profileUpdate=false;
  List<User> a = [];
  static double latitude;
  static double longitude;
  static CameraPosition _userLocation;
 var address;
  var addresses;
  var first;
  var contextDummy;
  bool statusUpdated;
   var token;
  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;
  Channel channel;
  ScrollController _scrollController = new ScrollController();
  String channelName = 'easy-blood';
  String eventName = "message";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<void> initializeLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    // app_icon needs to be a added as a drawable resource to the
    // Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var onDidReceiveLocalNotification;
    var selectNotification;
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void getUserData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
     setState(() {
       user= jsonDecode(localStorage.getString("user"));
       localStorage.setBool('statusUpdated',checkIfAnyIsNull());

       statusUpdated=localStorage.getBool('statusUpdated');
       print("ada la babi ${statusUpdated}");
       token = localStorage.getString('tokenNotification');
     });
     print(statusUpdated);
    print("idddd isss " + user["_id"]);
    print(token);
    lastDonation();

  }


  @override
  void initState(){
    super.initState();
    getUserData();

    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        print("onlaunch");

        addUserNotification();
      },
      onMessage: (Map<String, dynamic> message) async {
        print("onMessagwe: $message");
        print("onmessage berjaya la");
        notificationDialog(contextDummy);
        addUserNotification();
      },

      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        print("onresume");
        addUserNotification();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setState(() {
      contextDummy=context;
    });
    return   WillPopScope(
      onWillPop: _onBackPressed,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child:  user==null ? LoadingScreen() : Scaffold(
              drawer: Container(
                width: size.width*0.75,
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
                                child: statusUpdated==true ? FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  disabledColor: Colors.yellow,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Please update Profile"),
                                      FaIcon(
                                        FontAwesomeIcons.exclamation,
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile()),
                                    );
                                  },
                                ) : FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  disabledColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Profile",style: TextStyle(
                                          fontSize: size.width*0.031
                                      ),),
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
                                      Text("Request Blood",style: TextStyle(
                                          fontSize: size.width*0.031
                                      ),),
                                      FaIcon(
                                        FontAwesomeIcons.tint,
                                        color: kPrimaryColor,
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    getUserData();
                                    if(!checkIfAnyIsNull()){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RequestBlood()),
                                      );
                                    }else{
                                      updateProfileDialog(context);
                                    }

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
                                      Text("Find Request",style: TextStyle(
                                          fontSize: size.width*0.031
                                      ),),
                                      Icon(
                                        Icons.find_in_page,
                                        color: kPrimaryColor,
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    if(!checkIfAnyIsNull()){

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BloodRequest()),
                                      );
                                    }
                                    else{
                                      updateProfileDialog(context);
                                    }

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
                                      Text("Blood Event",style: TextStyle(
                                          fontSize: size.width*0.031
                                      ),),
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
                                      Text("Achievement",style: TextStyle(
                                          fontSize: size.width*0.031
                                      ),),
                                      FaIcon(
                                        FontAwesomeIcons.clipboardList,
                                        color: kPrimaryColor,
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    getUserData();
                                    if(!checkIfAnyIsNull()){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Achievement()),
                                      );
                                    }else{
                                      updateProfileDialog(context);
                                    }

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
                                      Text("Notification",style: TextStyle(
                                          fontSize: size.width*0.031
                                      ),),
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
                                      Text("Message",style: TextStyle(
                                          fontSize: size.width*0.031
                                      ),),
                                      FaIcon(
                                        FontAwesomeIcons.facebookMessenger,
                                        color: kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatHome()),
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
                                      Text("About",style: TextStyle(
                                          fontSize: size.width*0.031
                                      ),),
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
                                  top: 13, right: 8, left: 8,bottom: 20),
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
                                      Text("Log Out",style: TextStyle(
                                          fontSize: size.width*0.031
                                      ),),
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
//              bottomNavigationBar: CurvedNavigationBar(
//                key: _bottomNavigationKey,
//                index: 0,
//                height: 50.0,
//                items: <Widget>[
//                  Icon(Icons.add, size: 30,color: colorList[0]),
//                  Icon(Icons.list, size: 30,color: colorList[1]),
//                  Icon(Icons.compare_arrows, size: 30,color: colorList[2]),
//                  Icon(Icons.call_split, size: 30,color: colorList[3]),
//                  Icon(Icons.perm_identity, size: 30,color: colorList[4]),
//                ],
//                color:kGradient2.withOpacity(0.75),
//                buttonBackgroundColor: kPrimaryColor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ,
//                backgroundColor: Colors.white,
//                animationCurve: Curves.easeInOut,
//                animationDuration: Duration(milliseconds: 400),
//                onTap: (index) {
//                  setState(() {
//                    _page = index;
//                    if(_page==4){
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => Profile()),
//                      );
//                    }
//                  });
//                },
//              ),
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
                          right:size.width*0.1,
                          top: size.height*0.02,
                          child: Image.asset("assets/images/bloodcell.png",scale: 3,)),
                      Positioned(
                        right: size.width*0.7,
                        top:size.height*0.19,
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
                                    left: 10.0, top: 40.0),
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
                                                fontSize: size.width*0.051),
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
                                              wordSpacing: 2,
                                              fontSize: size.width*0.031),
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
                              SizedBox(height: size.height * 0.01),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right:8.0, top:5.0 ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.45,
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                    BorderRadius.circular(
                                                        11.00),
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      color: Colors.black
                                                          .withOpacity(0.3))
                                                ]),
                                            child: FlatButton(
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                    size: size.width*0.05,
                                                  ),
                                                  Text(
                                                    "Locate your location",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                    fontSize: size.width*0.031),
                                                  )
                                                ],
                                              ),
                                              onPressed: () {
                                                getUserLocation();
//                                                _updatelocation();
                                              },
                                            ),
                                          ),
                                        Container(
                                          width: size.width*0.27,
                                          height: size.height*0.05,
                                          decoration: BoxDecoration(
                                            color: Colors.yellowAccent,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Column(
                                            children: [
                                              Text("Latest Donation", style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Muli",
                                              color: Colors.black,fontSize: size.width*0.026),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[

                                                  Text(
                                                   " ${lastdonate} days ago",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                        fontFamily: "Muli",
                                                        color: Colors.black,fontSize: size.width*0.028),

                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        ],
                                      ),
                                      Container(
                                        height: size.height*0.05,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8.0,left: 8.0,top:3.0),
                                          child: Text(
                                              address == null ? "" : address,style: TextStyle(fontSize: size.width*0.026),),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
//                                Container(
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                    children: [
//                                      Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Container(
//                                            height: size.height * 0.05,
//                                            width: size.width * 0.13,
//                                            decoration: BoxDecoration(
//                                                boxShadow: [
//                                                  BoxShadow(
//                                                      color: Colors.black
//                                                          .withOpacity(0.2),
//                                                      blurRadius: 9,
//                                                      spreadRadius: 3)
//                                                ],
//                                                color: Colors.white,
//                                                borderRadius:
//                                                BorderRadius.circular(5)),
//                                            child: Row(
//                                              mainAxisAlignment:
//                                              MainAxisAlignment.center,
//                                              children: <Widget>[
//                                                Icon(
//                                                  FontAwesomeIcons.tint,
//                                                  color: Colors.red,
//                                                  size: 17,
//                                                ),
//                                                Padding(
//                                                  padding:
//                                                  const EdgeInsets.only(
//                                                      right: 8.0),
//                                                  child: Text(
//                                                    "A",
//                                                    style: TextStyle(
//                                                        fontWeight:
//                                                        FontWeight.w500,
//                                                        fontSize: 17),
//                                                  ),
//                                                )
//                                              ],
//                                            )),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Container(
//                                            height: size.height * 0.07,
//                                            width: size.width * 0.28,
//                                            decoration: BoxDecoration(
//                                                boxShadow: [
//                                                  BoxShadow(
//                                                      color: Colors.black
//                                                          .withOpacity(0.2),
//                                                      blurRadius: 9,
//                                                      spreadRadius: 3)
//                                                ],
//                                                color: Colors.white,
//                                                borderRadius:
//                                                BorderRadius.circular(5)),
//                                            child: Row(
//                                              mainAxisAlignment:
//                                              MainAxisAlignment.center,
//                                              children: <Widget>[
//                                                Icon(
//                                                  FontAwesomeIcons.clock,
//                                                  color: Colors.red,
//                                                ),
//                                                Padding(
//                                                  padding:
//                                                  const EdgeInsets.only(
//                                                      left: 8.0),
//                                                  child: Container(
//                                                    child: Text(
//                                                      "90 Days left",
//                                                      style: TextStyle(
//                                                          fontWeight:
//                                                          FontWeight.w500,
//                                                          fontSize: 12),
//                                                    ),
//                                                  ),
//                                                )
//                                              ],
//                                            )),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Container(
//                                            height: size.height * 0.05,
//                                            width: size.width * 0.13,
//                                            decoration: BoxDecoration(
//                                                boxShadow: [
//                                                  BoxShadow(
//                                                      color: Colors.black
//                                                          .withOpacity(0.2),
//                                                      blurRadius: 9,
//                                                      spreadRadius: 3)
//                                                ],
//                                                color: Colors.white,
//                                                borderRadius:
//                                                BorderRadius.circular(5)),
//                                            child: Row(
//                                              mainAxisAlignment:
//                                              MainAxisAlignment.center,
//                                              children: <Widget>[
//                                                Icon(
//                                                  FontAwesomeIcons.child,
//                                                  color: Colors.red,
//                                                  size: 17,
//                                                ),
//                                                Padding(
//                                                  padding:
//                                                  const EdgeInsets.only(
//                                                      right: 8.0),
//                                                  child: Text(
//                                                    "29",
//                                                    style: TextStyle(
//                                                        fontWeight:
//                                                        FontWeight.w500,
//                                                        fontSize: 17),
//                                                  ),
//                                                )
//                                              ],
//                                            )),
//                                      ),
//                                    ],
//                                  ),
//                                ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Blood Type:",style: TextStyle(
                                              fontSize: size.width*0.031
                                          ),),
                                          user["bloodType"]==null ? Text("None", style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,

                                          fontSize: size.width*0.031
                                          ),) : Text(
                                            user["bloodType"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: size.width*0.031
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Text("Age:",style: TextStyle(
                                              fontSize: size.width*0.031
                                          ),),
                                          Text(
                                            '${user["age"]}',
                                            style: TextStyle(
                                                fontSize: size.width*0.031,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Text("Weight:",style: TextStyle(
                                              fontSize: size.width*0.031
                                          ),),

                                          Container(
                                            decoration: BoxDecoration(

                                            ),
                                            child: Text(
                                              user["weight"]==null ? "None" : "${user["weight"]} KG",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: size.width*0.031
                                              ),
                                            ),
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
                                              height: size.height*0.06,
                                              width: size.width*0.15,
                                              child: FlatButton(
                                                child: Image.asset(
                                                  "assets/images/requestblood2.png",
                                                ),
                                                shape: CircleBorder(),
                                                onPressed: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => RequestBlood()),
                                                  );
                                                },
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.2),
                                                        blurRadius: 9,
                                                        spreadRadius: 3
                                                    )
                                                  ]
                                              ),
                                            ),
                                            Container(
                                              height: size.height*0.06,
                                              width: size.width*0.15,
                                              child: FlatButton(
                                                child: Image.asset(
                                                  "assets/images/donor.png",
                                                ),
                                                  shape: CircleBorder(
                                                  ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>  BloodRequest()),
                                                  );
                                                },
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,

                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.2),
                                                        blurRadius: 9,
                                                        spreadRadius: 3
                                                    )
                                                  ]
                                              ),
                                            ),
                                            Container(
                                              height: size.height*0.06,
                                              width: size.width*0.15,
                                              child: FlatButton(
                                                child: Image.asset(
                                                  "assets/images/icons-event.png",
                                                ),
                                                shape: CircleBorder(),
                                                onPressed: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => BloodEvent()),
                                                  );
                                                },
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.2),
                                                    blurRadius: 9,
                                                    spreadRadius: 3
                                                  )
                                                ]
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
                                    fontSize: size.width*0.031
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
                               height: size.height*0.37,
                               width: size.width*0.98,
                               decoration: BoxDecoration(
                                   color: Colors.white70,
                                   borderRadius: BorderRadius.circular(5),

                                   boxShadow: [
                                     BoxShadow(
                                         color: Colors.grey.withOpacity(0.3),
                                         blurRadius: 5,
                                         spreadRadius: 3
                                     )
                                   ]
                               ),
                               child: Column(
                                 children: <Widget>[
                                   Container(
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                       gradient: colorgradient2

                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.only(bottom:3.0,top:2.0, left:8.0,right:8.0),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: <Widget>[
                                           Text("New Campaign",style: TextStyle(
                                               fontWeight: FontWeight.w700,
                                               fontSize: size.width*0.033),
                                                ),
                                                GestureDetector(
                                                  child: Text("See All",style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: size.width*0.033),),
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
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 17.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: size.height*0.28,
                                                      width: size.width*0.98,
                                           child:  ListView.builder(
                                                 shrinkWrap: true,
                                                 scrollDirection: Axis.horizontal,
                                                 itemCount: snapshot.data.length,
                                                 itemBuilder: (BuildContext context, int index){
                                                 DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                                                 var dateStart = dateFormat.format(snapshot.data[index].dateStart);
                                                 var currentTime = DateFormat.jm().format(snapshot.data[index].dateStart);

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
                                                                width: size.width*0.8,
                                                                child: Stack(
                                                                  children: <
                                                                      Widget>[

                                                                    Positioned(
                                                                      bottom:
                                                                          size.height*0.014,
                                                                      left: 60,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left:8.0,top:15.0),
                                                             child: Container(
                                                                 height: size.height*0.26,
                                                               width: size.width*0.6,
                                                               decoration: BoxDecoration(
                                                                   borderRadius:
                                                                   BorderRadius.circular(10.0),
                                                                   color: Colors.white,
                                                                   boxShadow: [
                                                                     BoxShadow(
                                                                         color: Colors.grey.withOpacity(0.1),
                                                                         blurRadius: 5,
                                                                         spreadRadius: 3,
                                                                         offset: Offset(0.0, 0.75)
                                                                     )
                                                                   ]
                                                               ),
                                                               child: Padding(
                                                                 padding: const EdgeInsets.only(left: 55.0,top:25.0),
                                                                 child: Column(
                                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                   children: <Widget>[
                                                                     Text(snapshot.data[index].name,style: TextStyle(
                                                                         fontWeight: FontWeight.w900,
                                                                         fontSize: size.width*0.033
                                                                     ),),
                                                                     Text("DATE",
                                                                       style: TextStyle(
                                                                         color: Colors.black,
                                                                           fontSize: size.width*0.030,
                                                                       fontWeight: FontWeight.w600),),
                                                                     Text(
                                                                       dateStart,
                                                                       style: TextStyle(
                                                                         color: Colors.black,
                                                                         fontSize: size.width*0.029,),
                                                                     ),
                                                                     Text("TIME",
                                                                       style: TextStyle(
                                                                           color: Colors.black,
                                                                           fontSize: size.width*0.030,
                                                                           fontWeight: FontWeight.w600),),
                                                                     Text(
                                                                       currentTime,
                                                                       style: TextStyle(
                                                                         color: Colors.black,
                                                                         fontSize: size.width*0.029,),
                                                                     ),
                                                                     Text("LOCATION",
                                                                       style: TextStyle(
                                                                           color: Colors.black,
                                                                           fontSize: size.width*0.030,
                                                                           fontWeight: FontWeight.w600),),
                                                                     Text(
                                                                       snapshot.data[index].location,
                                                                       style: TextStyle(
                                                                         color: Colors.black,
                                                                         fontSize: size.width*0.029,),
                                                                     ),
                                                                   ],
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                         ),
//                                                                    Padding(
//                                                                      padding: const EdgeInsets.all(10.0),
//                                                                      child: Container(
//                                                                        width: 100,
//                                                                        height: 140,
//                                                                        decoration: BoxDecoration(
//                                                                            borderRadius:
//                                                                            BorderRadius.circular(10.0),
//                                                                            color: Colors.white,
//                                                                            boxShadow: [
//                                                                              BoxShadow(
//                                                                                  spreadRadius: 4,
//                                                                                  color: Colors.grey
//                                                                                      .withOpacity(0.1),
//                                                                                  blurRadius: 2)
//                                                                            ]),
//                                                                      ),
//                                                                    ),
                                                         Padding(
                                                           padding: const EdgeInsets.only(left:5.0,top:18.0),
                                                           child: Container(
                                                             height: size.height*0.21,
                                                             width: size.width*0.25,
                                                             decoration: BoxDecoration(
                                                                 borderRadius:
                                                                 BorderRadius.circular(20.0),
                                                                 boxShadow: [
                                                                   BoxShadow(
                                                                       spreadRadius: 4,
                                                                       color: Colors.grey
                                                                           .withOpacity(0.3),
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
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                        height: size.height*0.33,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 3,
                                                  blurRadius: 12)
                                            ]),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                                  gradient: colorgradient2

                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom:3.0,top:2.0, left:8.0,right:8.0),
                                                child: Row(
                                          mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Recent Requests",style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                            fontSize: size.width*0.033),),
                                            GestureDetector(
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => BloodRequest()),
                                                  );
                                                },
                                                child: Text("See All",style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: size.width*0.033),),
                                            )
                                          ],
                                        ),
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
                                          else{
                                            return  Container(
                                                height:size.height*0.291,
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
                                                                  Row(
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
                                                                                fontSize: size.width*0.033),
                                                                          ),
                                                                          Text(
                                                                            snapshot.data[index].location,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: size.width*0.031),
                                                                          ),
                                                                          Text(
                                                                            Jiffy(time).fromNow() // 7 years ago
                                                                            ,
                                                                            style: TextStyle(
                                                                                color: Colors.grey,
                                                                                fontSize: size.width*0.029,
                                                                                fontWeight: FontWeight.w300),
                                                                          ),
                                                                        ],
                                                                      ),

                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    snapshot.data[index].bloodType,
                                                                    style:
                                                                    TextStyle(color: kPrimaryColor,fontSize: size.width*0.033),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );}
                                                ));
                                          }
                                        },
                                      )
                                      ],
                                    ),
                                  ),
                              ),
                              SizedBox(height: size.height*0.03,),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: size.width*1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                     borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 9
                                      )
                                    ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                            Container(
                                              width: size.width*0.7,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("Invite Your Friends",style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: size.width*0.031

                                                  ),),
                                                  Text("Inviting more people to become the life savior, it could be someone that you know.",style: TextStyle(
                                                    fontWeight: FontWeight.w500,

                                                  fontSize: size.width*0.031

                                                  ),)
                                                ],
                                              ),
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
                                                  Share.share('check out my website http://laraveleasyblood-env.eba-kezjpqpc.ap-southeast-1.elasticbeanstalk.com/');
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
                                        ),

                                      ],

                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height*0.03,),

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
    );

  }


  Future<void> disposePusher()async{
//    await channel.unbind(eventName);
    await Pusher.unsubscribe(channelName);
    Pusher.disconnect();
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
                child: Text("No",style: TextStyle(
                    color: Colors.red
                ),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Yes",style: TextStyle(
                    color: Colors.red
                ),),
                onPressed: (){
                  disposePusher();
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
  Future<String> lastDonation() async{

var response = await Api().getData("${user["_id"]}/qualification");
print("cibaiii luu "+ "${user["_id"]}/qualification");

if(response.statusCode==200){

  setState(() {
    lastdonate = response.body.toString();

  });
  return response.body;
}
  }


  void getUserLocation()async{
    var coordinates;
    await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
    .then((position){
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        coordinates = new Coordinates(position.latitude,position.longitude);
      });
    });
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      first = addresses.first;
      address=first.addressLine.toString();
    });

    }

    void _updatelocation()async{
      var data={
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "type": "updateLocation"
      };

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      statusUpdated=localStorage.getBool('statusUpdated');
      user = jsonDecode(localStorage.getString("user"));
      var uploadEndPoint = "user/${user['_id']}";
      var res=  await Api().updateData(data,uploadEndPoint);
      print(uploadEndPoint);

      if (res.statusCode == 200) {
        print("success");
      }
    }

  bool checkIfAnyIsNull() {
    return [user['imageURL'],
      user['email'],
      user['username'],
      user['age'],
      user['gender'],
      user['bloodType'],
      user['height'],
      user['imageURL'],
      user['latitude'],
      user['longitude'],
      user['phoneNumber'],
      user['weight']].contains(null);
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


  Future<List<Campaign>> fetchEvent() async {

    var res = await Api().getData("event");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Campaign> events = [];
      for (Map u in body) {
        Campaign event = Campaign.fromJson(u);
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


  Future<void> addUserNotification() async{
    var data = {
      "notification_id": "5fb2151a4580d49d1570018f",
      "user_id": user['_id'],
      "is_read": false,
    };

    var res = await Api().postData(data, "userNotification");
    print(res.statusCode);
    if (res.statusCode == 200) {
      print("notification berjaya");
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






Future<bool> notificationDialog(context){
  return showDialog(
    context: context,
    builder: (BuildContext context) => CustomDialogNotification(
        title: "New Event Has been Added",
        description:
        "Someone has added new event. Lets join!",
        buttonText: "Okay",
        image: "assets/images/eligible.png"
    ),
  );
}


Future<bool> updateProfileDialog(context){
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          title: Text("Profile not updated!"),
          content: Text("Please update your profile to use this service!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Back",style: TextStyle(
                color: Colors.red
              ),),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Update Profile",style: TextStyle(
                  color: Colors.red
              ),),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile()),
                );
              },
            ),
          ],
        );
      }
  );

}

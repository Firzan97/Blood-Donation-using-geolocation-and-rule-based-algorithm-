import 'dart:convert';

import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/constant.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/home/home.dart';
import 'package:easy_blood/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Muli"
        ),
        home: Scaffold(
            body: Stack(
              children: <Widget>[
                Image.asset("assets/images/bloodcell.png",),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [kGradient1.withOpacity(0.8), kGradient2]),
                  ),
                  child: Column(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 25,bottom: 15.0),
                        child: Container(
                          child: Column(children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: (){
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  },
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage("assets/images/lari2.jpg"))),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Notification",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 17),
                            child: Container(height: size.height*0.75,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0,top:8,bottom: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))),
                                      child: FutureBuilder(
                                        future: addUserNotifiction(),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              AssetImage("assets/images/lari2.jpg"))),
                                                ),
                                                title: RichText(
                                                  text: TextSpan(
                                                    text: 'Firzan, ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18.0,
                                                    color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'has request blood from you',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.black)),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Text("7 minutes ago.."),
                                              ),
                                              ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                          AssetImage("assets/images/lari2.jpg"))),
                                                ),
                                                title: RichText(
                                                  text: TextSpan(
                                                    text: 'Firzan, ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18.0,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'has request blood from you',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.black)),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Text("7 minutes ago.."),
                                              ),
                                              ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                          AssetImage("assets/images/lari2.jpg"))),
                                                ),
                                                title: RichText(
                                                  text: TextSpan(
                                                    text: 'Firzan, ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18.0,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'has request blood from you',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.black)),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Text("7 minutes ago.."),
                                              ),
                                              ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                          AssetImage("assets/images/lari2.jpg"))),
                                                ),
                                                title: RichText(
                                                  text: TextSpan(
                                                    text: 'Firzan, ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18.0,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'has request blood from you',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.black)),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Text("7 minutes ago.."),
                                              ),
                                              ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                          AssetImage("assets/images/lari2.jpg"))),
                                                ),
                                                title: RichText(
                                                  text: TextSpan(
                                                    text: 'Firzan, ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18.0,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'has request blood from you',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.black)),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Text("7 minutes ago.."),
                                              ),
                                              ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                          AssetImage("assets/images/lari2.jpg"))),
                                                ),
                                                title: RichText(
                                                  text: TextSpan(
                                                    text: 'Firzan, ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18.0,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'has request blood from you',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.black)),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Text("7 minutes ago.."),
                                              ),
                                              ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                          AssetImage("assets/images/lari2.jpg"))),
                                                ),
                                                title: RichText(
                                                  text: TextSpan(
                                                    text: 'Firzan, ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18.0,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'has request blood from you',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.black)),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Text("7 minutes ago.."),
                                              ),
                                              ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                          AssetImage("assets/images/lari2.jpg"))),
                                                ),
                                                title: RichText(
                                                  text: TextSpan(
                                                    text: 'Firzan, ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18.0,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'has request blood from you',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.black)),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Text("7 minutes ago.."),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                ),
        ),
              ],
            )),
      ),
    );
  }

  Future<List<UserNotification>> fetchEvent() async {

    var res = await Api().getData("userNotification");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<UserNotification> userNotifications = [];
      var count=0;
      for (var u in body) {
        count++;
        userNotification userNotification = userNotification.fromJson(u);
        userNotifications.add(userNotification);
      }

      return userNotifications;
    } else {
      throw Exception('Failed to load album');
    }
  }

}

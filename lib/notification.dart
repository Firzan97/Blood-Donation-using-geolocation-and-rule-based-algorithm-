import 'dart:convert';

import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/constant.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/home/home.dart';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/custom_dialog.dart';
import 'package:easy_blood/component/custom_dialog_notification.dart';
import 'package:easy_blood/model/notification.dart';
import 'package:easy_blood/model/user_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'loadingScreen.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  List<NotificationData> notimessage=[];
  var color = Colors.white;
   var user;
  @override
  void initState(){
    super.initState();
    getUserData();
    fetchUserNotification();
  }

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
                                            image: user == null
                                                ? NetworkImage(
                                                'https://easy-blood.s3-ap-southeast-1.amazonaws.com/loadingProfileImage.png')
                                                : NetworkImage(user[
                                            'imageURL']))),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Notification",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: size.width*0.06),
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
                            child: Container(height: size.height*0.78,
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
                                        future: fetchUserNotification(),
                                        builder: (context,snapshot){
                                          if (snapshot.data == null) {

                                            return Container(
                                              height: size.height*0.3,
                                              width: size.width*0.9,
                                              child: Center(
                                                child: LoadingScreen(),
                                              ),
                                            );
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              itemCount: snapshot.data.length,
                                                itemBuilder: (context,index){
                                                  var time;
                                                  DateTime dateTime = DateTime.parse(snapshot.data[index].created_at);
                                                  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                                                  time = dateFormat.format(dateTime);
                                                  return SingleChildScrollView(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: snapshot.data[index].is_read!=true ? Colors.grey : Colors.white,
                                                              borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            child: FlatButton(
                                                              onPressed: (){
                                                                updateIsRead(snapshot.data[index].id);
                                                                notificationDialog(context);
                                                              },
                                                              child: ListTile(
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
                                                                        fontSize: 15.0,
                                                                        color: Colors.black),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: notimessage[index].message,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w300,
                                                                              color: Colors.black)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                subtitle: Text("${timeago.format(dateTime)} ..."),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          );
                                        }

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

  Future<void> updateIsRead(usernotification_id)async{

    var data={
      "is_read": true
    };
   print(usernotification_id);
    var res = await Api().updateData(data,"notification/${usernotification_id}");
    if (res.statusCode == 200) {
      setState(() {
        fetchUserNotification();
      });
    }
  }

  void getUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(localStorage.getString("user"));
    });
    print(user['created_at']);
  }

  Future<List<UserNotification>> fetchUserNotification() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user= jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("user/${user['_id']}/notification");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print("user/${user['_id']}/notification");
      List<UserNotification> userNotifications = [];
      var count=0;
      for (var u in body) {
        count++;
        UserNotification userNotification = UserNotification.fromJson(u);
        userNotifications.add(userNotification);

        NotificationData a = userNotification.notification;
        notimessage.add(a);


      }

      return userNotifications;
    } else {
      throw Exception('Failed to load album');
    }
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

}

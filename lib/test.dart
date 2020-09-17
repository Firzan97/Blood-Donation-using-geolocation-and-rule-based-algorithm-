import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}


class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token1;



  void firebaseCloudMessaging_Listeners() {
    //get token of mobile device
    _firebaseMessaging.getToken().then((token) {print("Token is" + token);
    token1= token;
    print(token1);
    setState(() {

    });} );
  }


  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: (){
                //do something
                getQue();
              },
              color: Colors.orange,
              padding: EdgeInsets.all(10.0),
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.notifications,color: Colors.white),
                  SizedBox(height: 10,),
                  Text("Send",style: TextStyle(
                      color: Colors.white
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future getQue() async {

    if(token1!=null){
      //call php file
      var data={
        "token": token1,
      };print(token1);
      var res = await Api().postData(data,"notification");
//        return json.decode(res.body);
    }
    else{
      print("Token is null");
    }
  }
}
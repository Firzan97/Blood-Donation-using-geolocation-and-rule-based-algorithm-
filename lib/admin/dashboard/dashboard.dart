import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import "package:easy_blood/admin/dashboard/profile.dart";
import 'package:easy_blood/admin/donation/donation.dart';
import 'package:easy_blood/admin/event/event.dart';
import 'package:easy_blood/admin/request/requestList.dart';
import 'package:easy_blood/admin/user/user.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
var user;
String suis="OFF";
var i,_value="Default";
var background = kPrimaryColor,card= Colors.white;
  void _getUserData()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user= jsonDecode(pref.getString("user"));
      print(user);
    });
  }
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Muli",
      ),
      home: Scaffold(
        body: Container(
          height: size.height*1,
          decoration: BoxDecoration(
            color: background
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.settings,color: Colors.black,),
                      onPressed: (){
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.NO_HEADER,
                          body: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Light Mode"),
                                  FlatButton(
                                    color: Colors.red,
                                    child: Text(suis),
                                    onPressed: (){
                                      setState(() {
                                        if(suis=="OFF")
                                          suis="ON";
                                        else
                                          suis="OFF";
                                      });

                                    },
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Dark Mode"),
                                  FlatButton(
                                    color: Colors.red,
                                    child: Text(suis),
                                    onPressed: (){
                                      setState(() {
                                        if(suis=="OFF")
                                          suis="ON";
                                        else
                                          suis="OFF";
                                      });

                                    },
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Default Mode"),
                                  FlatButton(
                                    color: Colors.red,
                                    child: Text(suis),
                                    onPressed: (){
                                      setState(() {
                                        if(suis=="OFF")
                                          suis="ON";
                                        else
                                          suis="OFF";
                                      });
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        )..show();
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => AdminSetting()),
//                        );
                      },
                    ),
                    Column(
                      children: <Widget>[
                        Container(height: size.height*0.1,width: size.width*0.3,child: Image.asset("assets/images/humaaans.png")),
                        Text("Easy Blood",style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w500
                        ),),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications_active,color: Colors.black,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height*0.02,),
              Text(user==null ? "" : "Welcome aboard, Admin ${user['username']} ...",style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20
              ),),
              SizedBox(height: size.height*0.02,),
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color:card,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 3,
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 9
                                )
                              ]
                            ),
                            height: size.height*0.15,
                              width: size.width*0.4,
                              child: FlatButton(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.person_outline),
                                    Text("Profile")
                                  ],
                                ),
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()),
                                  );
                                },
                              ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: card,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 3,
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 9
                                  )
                                ]
                            ),
                            height: size.height*0.15,
                            width: size.width*0.4,
                            child: FlatButton(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.people_outline),
                                  Text("User")
                                ],
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserList()),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: card,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 3,
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 9
                                  )
                                ]
                            ),
                            height: size.height*0.15,
                            width: size.width*0.4,
                            child: FlatButton(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.event),
                                  Text("Event")
                                ],
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>EventList()),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: card,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 3,
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 9
                                  )
                                ]
                            ),
                            height: size.height*0.15,
                            width: size.width*0.4,
                            child: FlatButton(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.help_outline),
                                  Text("Request")
                                ],
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RequestList()),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color:card,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 3,
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 9
                                  )
                                ]
                            ),
                            height: size.height*0.15,
                            width: size.width*0.4,
                            child: FlatButton(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.done_outline),
                                  Text("Blood Donate")
                                ],
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: card,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 3,
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 9
                                  )
                                ]
                            ),
                            height: size.height*0.15,
                            width: size.width*0.4,
                            child: FlatButton(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.lock_open),
                                  Text("Log Out")
                                ],
                              ),
                              onPressed: (){
                                LogOutDialog(context);
                                print("babi");
                              },
                            ),
                          )
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
    );
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

Future<bool> AdminSetting(context){
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Alert!"),
          content: Text("Are you sure want to Logout?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Exit"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Save"),
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

  void LogOut() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("user", null);
    var email2=pref.getString("userEmail");
    print(email2);
  }
}

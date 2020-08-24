import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/bloodEvent.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_date.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/component/input_time.dart';
import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';



class AddBloodEvent extends StatefulWidget {
  @override
  _AddBloodEventState createState() => _AddBloodEventState();
}

class _AddBloodEventState extends State<AddBloodEvent> {

  TextEditingController eventName = new TextEditingController();
  TextEditingController eventLocation = new TextEditingController();
  TextEditingController eventTime = new TextEditingController();
  TextEditingController eventDate = new TextEditingController();

  bool _isLoading=false;
  String error="";
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: size.height*0.3,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 3
                    )],
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFd50000),
                        kPrimaryColor,
                      ]
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BloodEvent()),
                                );
                              },
                            ),
                            SizedBox(width: size.width*0.30),
                            Text("ADD EVENT"),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height*0.06,),
                      Text("Add Photo"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width*0.27,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.arrow_upward,size: 35.0,),
                                  Text("Upload", style: TextStyle(
                                    fontSize: 17.0
                                  ),)
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height*0.05,),
                Container(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        InputRound(
                          controller: eventName,
                          deco: InputDecoration(
                            hintText: "Event Name",
                            border: InputBorder.none,
                            icon: Icon(Icons.event_available, color: kThirdColor,),
                          ),
                          validator: (value) =>
                          (value.isEmpty) ? 'Please enter some text' :
                          null,
                        ),
                        InputRound(
                          controller: eventLocation,
                          deco: InputDecoration(
                            hintText: "Location",
                            border: InputBorder.none,
                            icon: Icon(Icons.location_on, color: kThirdColor,),
                          ),
                          validator: (value) =>
                          (value.isEmpty) ? 'Please enter some text' :
                          null,
                        ),
                        InputDate(),
                        InputTime(),
                        ButtonRound(
                          color: Color(0XFF343a69),
                          text: "CONFIRM",
                          press: () async {
                            if (_formkey.currentState.validate()) {
                              print("Validate");
                              addEvent();
                            }
                            else{
                              error =
                              "Could  not sign in. Wrong input ";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() async
  {
    setState(() {
      _isLoading = true;
    });

    var data={
      'name' : eventName.text,
      'location' : eventLocation.text,
    };

    var res = await Api().postData(data,"event");
    var body = json.decode(res.body);
    print(body);
  }
}




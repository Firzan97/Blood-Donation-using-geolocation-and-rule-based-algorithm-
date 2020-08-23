import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_date.dart';
import 'package:easy_blood/component/input_password_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/component/input_time.dart';
import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';


class AddBloodEvent extends StatefulWidget {
  @override
  _AddBloodEventState createState() => _AddBloodEventState();
}

class _AddBloodEventState extends State<AddBloodEvent> {

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController gender = new TextEditingController();

  bool _isLoading=false;
  String error="";
  final _formkey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height*0.3,
              decoration: BoxDecoration(
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
                      controller: email,
                      deco: InputDecoration(
                        hintText: "Event Name",
                        border: InputBorder.none,
                        icon: Icon(Icons.email, color: kThirdColor,),
                      ),
                      validator: (value) =>
                      (value.isEmpty) ? 'Please enter some text' :
                      null,
                    ),
                    InputRound(
                      controller: username,
                      deco: InputDecoration(
                        hintText: "Location",
                        border: InputBorder.none,
                        icon: Icon(Icons.person, color: kThirdColor,),
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
    );
  }
}

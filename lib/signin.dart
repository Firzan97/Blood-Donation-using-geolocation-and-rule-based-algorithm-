import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/already_have_account.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_password_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/home.dart';
import 'package:easy_blood/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String error = "";


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ),
    child:Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text("LOGIN",style: TextStyle(
                  fontFamily: "Muli",
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: kPrimaryColor

                ),),
              ),
              SizedBox(height: 20.0,),
              Image.asset("assets/images/blood2.png", width: size.height*0.3,),
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    InputRound(
                      controller: email,
                      deco: InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        icon: Icon(Icons.email, color: kGradient1,),
                      ),
                      validator: (value) =>
                      (value.isEmpty) ? 'Please enter some text' :
                      null,
                    ),
                    InputPasswordRound(
                      controller: password,
                      validator: (val) =>
                      val.length < 6
                          ? "Enter a password 6+ chars long"
                          : null,
                    ),
                    ButtonRound(
                      color: kPrimaryColor,
                      text: "LOGIN",
                      press: () async {
                        if (_formkey.currentState.validate()) {
                          print("Validate");
                          print(login());
                          login().then((value) {
                            if(value==200){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            }
                          });
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
              SizedBox(height: size.height * 0.02),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
Future<int> login() async
{
  var res = await Api().getData("user");
  var body = json.decode(res.body);
  return res.statusCode;
}



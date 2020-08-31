import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/already_have_account.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_password_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/home.dart';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                        icon: Icon(Icons.email, color: kPrimaryColor,),
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
                      press: (){
                        login();
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

  Future<void> login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (_formkey.currentState.validate()) {
    } else {
      print("Could  not sign in. Wrong input ");
    }

    var res = await Api().getData("user");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<User> users = [];
      for (var u in body) {
        if (u["email"] == email.text) {
          pref.setString("userEmail", email.text);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
          print("ada");
        }
//  users.add(user);
//          print('DAH MASUK');

      }
    }
  }
}

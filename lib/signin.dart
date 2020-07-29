import 'package:easy_blood/component/already_have_account.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_password_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text("LOGIN",style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 25.0,

                ),),
              ),
              SizedBox(height: 30.0,),
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
                        icon: Icon(Icons.email, color: kThirdColor,),
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
                      color: Color(0XFF343a69),
                      text: "LOGIN",
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
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  widget.toggleView();
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}

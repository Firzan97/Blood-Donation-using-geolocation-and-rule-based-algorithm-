import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/already_have_account.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_password_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/signin.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 40.0),
                   child: Center(
                     child: Column(
                       children: <Widget>[
                         Text("COME JOIN US NOW!",style: TextStyle(
                           fontWeight: FontWeight.w300,
                           fontSize: 15.0,

                         ),),
                         SizedBox(height: 10.0,),
                         Image.asset("assets/images/joinus.png", width: size.height*0.25,),
                         SizedBox(height: 30.0,),
                         Form(
                           key: _formkey,
                           child: Column(
                             children: <Widget>[
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
                               InputRound(
                                 controller: username,
                                 deco: InputDecoration(
                                   hintText: "Username",
                                   border: InputBorder.none,
                                   icon: Icon(Icons.person, color: kThirdColor,),
                                 ),
                                 validator: (value) =>
                                 (value.isEmpty) ? 'Please enter some text' :
                                 null,
                               ),
//                               InputRound(
//                                 controller: phoneNumber,
//                                 deco: InputDecoration(
//                                   hintText: "Phone Number",
//                                   border: InputBorder.none,
//                                   icon: Icon(Icons.phone, color: kThirdColor,),
//                                 ),
//                                 validator: (value) =>
//                                 (value.isEmpty) ? 'Please enter some text' :
//                                 null,
//                               ),
                               InputRound(
                                 controller: age,
                                 deco: InputDecoration(
                                   hintText: "Age",
                                   border: InputBorder.none,
                                   icon: Icon(Icons.calendar_today, color: kThirdColor,),
                                 ),
                                 validator: (value) =>
                                 (value.isEmpty) ? 'Please enter some text' :
                                 null,
                               ),
//                               InputRound(
//                                 controller: gender,
//                                 deco: InputDecoration(
//                                   hintText: "Gender",
//                                   border: InputBorder.none,
//                                   icon: Icon(Icons.people, color: kThirdColor,),
//                                 ),
//                                 validator: (value) =>
//                                 (value.isEmpty) ? 'Please enter some text' :
//                                 null,
//                               ),
                               InputPasswordRound(
                                 controller: password,
                                 validator: (val) =>
                                 val.length < 6
                                     ? "Enter a password 6+ chars long"
                                     : null,
                               ),
                               ButtonRound(
                                 color: Color(0XFF343a69),
                                 text: "SIGN UP",
                                 press: () async {
                                   if (_formkey.currentState.validate()) {
                                     print("Validate");
                                     register();
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => SignIn()),
                                     );
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
                         AlreadyHaveAnAccountCheck(
                           login: false,
                           press: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => SignIn()),
                             );
                           },
                         ),
                         Text(
                           error,
                           style: TextStyle(color: Colors.red),
                         ),

                       ],
                     ),
                   ),
                 ),
        )),
      ),
    );
  }

  void register() async
  {
    setState(() {
      _isLoading = true;
    });

    var data={
      "email" : email.text,
      "username" : username.text,
      "password" : password.text,
      "age" : age.text,
    };

    var res = await Api().postData(data,"user");
    print(res.statusCode);
    if(res.statusCode==200) {
      var body = json.decode(res.body);
      print(body);
    }

  }

}



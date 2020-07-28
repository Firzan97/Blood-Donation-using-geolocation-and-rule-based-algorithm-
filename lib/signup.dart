import 'package:easy_blood/component/already_have_account.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_password_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String error="";
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 80.0),
               child: Center(
                 child: Column(
                   children: <Widget>[
                     Text("COME JOIN US NOW!",style: TextStyle(
                       fontWeight: FontWeight.w300,
                       fontSize: 15.0,

                     ),),
                     SizedBox(height: 40.0,),
                     Image.asset("assets/images/joinus.png", width: size.height*0.25,),
                     SizedBox(height: 30.0,),
                     Form(
                       key: _formkey,
                       child: Column(
                         children: <Widget>[
                           InputRound(
                             deco: InputDecoration(
                               hintText: "Email",
                               border: InputBorder.none,
                               icon: Icon(Icons.email, color: kThirdColor,),
                             ),
                           ),
                           InputRound(
                             deco: InputDecoration(
                               hintText: "Username",
                               border: InputBorder.none,
                               icon: Icon(Icons.email, color: kThirdColor,),
                             ),
                           ),
                           InputRound(
                             deco: InputDecoration(
                               hintText: "Phone Number",
                               border: InputBorder.none,
                               icon: Icon(Icons.email, color: kThirdColor,),
                             ),
                           ),
                           InputRound(
                             deco: InputDecoration(
                               hintText: "Age",
                               border: InputBorder.none,
                               icon: Icon(Icons.email, color: kThirdColor,),
                             ),
                           ),
                           InputRound(
                             deco: InputDecoration(
                               hintText: "Gender",
                               border: InputBorder.none,
                               icon: Icon(Icons.email, color: kThirdColor,),
                             ),
                           ),
                           InputPasswordRound(),
                           ButtonRound(
                             color: Color(0XFF343a69),
                             text: "SIGN UP",
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
                     AlreadyHaveAnAccountCheck(
                       login: false,
                       press: () {
                         widget.toggleView();
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
    ));
  }
}

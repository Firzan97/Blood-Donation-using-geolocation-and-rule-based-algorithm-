import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/already_have_account.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_password_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/constant.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/home/home.dart';
import 'package:easy_blood/signin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
   var pr;
  bool _isLoading = false;
  String error = "";
  final _formkey = GlobalKey<FormState>();
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
  void initState(){
    super.initState();
    firebaseCloudMessaging_Listeners();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Loading....',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: LoadingScreen(),
        elevation: 20.0,
        insetAnimCurve: Curves.elasticOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400,fontFamily: "Muli"),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600, fontFamily: "Muli")
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SingleChildScrollView(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "COME JOIN US NOW!",
                        style: TextStyle(
                          fontFamily: "Muli",
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Image.asset(
                        "assets/images/joinus.png",
                        width: size.height * 0.25,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            InputRound(
                              controller: email,
                              deco: InputDecoration(
                                hintText: "Email",
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.email,
                                  color: kPrimaryColor,
                                ),
                              ),
                              validator: (value) => (value.isEmpty)
                                  ? 'Please enter some text'
                                  : null,
                            ),
                            InputRound(
                              controller: username,
                              deco: InputDecoration(
                                hintText: "Username",
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.person,
                                  color: kPrimaryColor,
                                ),
                              ),
                              validator: (value) => (value.isEmpty)
                                  ? 'Please enter some text'
                                  : null,
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
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: kPrimaryColor,
                                ),
                              ),
                              validator: (value) => (value.isEmpty)
                                  ? 'Please enter some text'
                                  : null,
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
                              validator: (val) => val.length < 6
                                  ? "Enter a password 6+ chars long"
                                  : null,
                            ),
                            ButtonRound(
                              color: kPrimaryColor,
                              text: "SIGN UP",
                              press: () async {
                                if (_formkey.currentState.validate()) {
                                  print("Validate");
                                  pr.show();
                                  register();
                                } else {
                                  error = "Could  not sign in. Wrong input ";
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
          )),
    );
  }

  void register() async {
    setState(() {
      _isLoading = true;
    });

    var data={
      "email" : email.text,
      "username" : username.text,
      "password" : password.text,
      "age" : age.text,
      "notificationToken": token1,
      "bloodType": "",
      "gender": "",
      "height": "",
      "imageURL": "",
      "latitude": "",
      "longitude": "",
      "phoneNumber": "",
      "weight": "",
      "role": "user",
    };
    print(age.text);
    print(token1);
    var res = await Api().postData(data,"user");
    var body = json.decode(res.body);
    print(res.statusCode);
    if(res.statusCode==200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      localStorage.setBool('statusUpdated',true);
      pr.hide();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home()),
      );
    }

  }

}



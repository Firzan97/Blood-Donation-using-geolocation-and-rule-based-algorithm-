import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/already_have_account.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/custom_dialog_notification.dart';
import 'package:easy_blood/component/input_password_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/home/home.dart';
import 'package:easy_blood/signin.dart';
import 'package:easy_blood/welcome/requirement.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_blood/admin/user/user.dart';
class AddAdmin extends StatefulWidget {
  final Function toggleView;

  AddAdmin({this.toggleView});

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  var pr;
  bool _isLoading = false,passwordValidator=false;
  String error = "";
  final _formkey = GlobalKey<FormState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token1;
  bool dataFilled= false;

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
    final bottom = MediaQuery.of(context).viewInsets.bottom;

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          resizeToAvoidBottomPadding:false,
          body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: bottom),

                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          bottom.toString(),
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
                        SvgPicture.asset(
                          "assets/images/welcome.svg",
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
                                onchanged: (value){
                                  setState(() {
                                    if(email.text!="" && password.text!="" && username.text!="" && age.text!="" ){
                                      dataFilled = true;
                                    }
                                    else{
                                      dataFilled = false;
                                    }
                                  });
                                },
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
                                onchanged: (value){
                                  setState(() {
                                    if(email.text!="" && password.text!="" && username.text!="" && age.text!="" ){
                                      dataFilled = true;
                                    }
                                    else{
                                      dataFilled = false;
                                    }
                                  });
                                },
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
                                keyboardType: TextInputType.number,
                                deco: InputDecoration(
                                  hintText: "Age",
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                onchanged: (value){
                                  setState(() {
                                    if(email.text!="" && password.text!="" && username.text!="" && age.text!="" ){
                                      dataFilled = true;
                                    }
                                    else{
                                      dataFilled = false;
                                    }
                                  });
                                },
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
                                  onchanged: (value){
                                    setState(() {
                                      if(email.text!="" && password.text!="" && username.text!="" && age.text!="" ){
                                        dataFilled = true;
                                      }
                                      else{
                                        dataFilled = false;
                                      }
                                    });
                                  },
                                  validator: (val) {
                                    if (val.length < 6) {
                                      passwordValidator = false;
                                    }
                                    else{
                                      passwordValidator = true;
                                    }
                                  }
                              ),
                              ButtonRound(
                                  color: kPrimaryColor,
                                  textColor: dataFilled==true ? Colors.white : Colors.grey,
                                  text: "ADD ADMIN",
                                  press: dataFilled==true ? () async {
                                    if (_formkey.currentState.validate()) {
                                      bool isValid = EmailValidator.validate(email.text);
                                      if(isValid==false){
                                        AwesomeDialog(
                                          context: context,
                                          dismissOnBackKeyPress: true,
                                          dialogType: DialogType.NO_HEADER,
                                          headerAnimationLoop: false,
                                          animType: AnimType.SCALE,
                                          title: 'Invalid Email',
                                          desc:
                                          'Please make sure that you entered the correct email format!',
                                        )
                                          ..show();
                                      }
                                      else if(passwordValidator==false){
                                        AwesomeDialog(
                                          context: context,
                                          dismissOnBackKeyPress: true,
                                          dialogType: DialogType.NO_HEADER,
                                          headerAnimationLoop: false,
                                          animType: AnimType.SCALE,
                                          title: 'Password too short!',
                                          desc:
                                          'Please make sure your password is at least 6 word!',
                                        )
                                          ..show();
                                      }
                                      else{
                                        pr.show();
                                        register();
                                      }
                                    }
                                  } : null
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
        ));
  }
  Future<void> updateNotificationToken($userid)async{
    var data={
      "notificationToken": token1,
    };
    var res = await Api().updateData(data, "user/${$userid}/notification");
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
      "bloodType": "a",
      "gender": "a",
      "height": "0",
      "imageURL": "https://easy-blood.s3-ap-southeast-1.amazonaws.com/loadProfileImage.png",
      "latitude": "0",
      "longitude": "0",
      "phoneNumber": "0",
      "weight": "0.0",
      "role": "admin",
    };
    print(age.text);
    print(token1);
    var res = await Api().postData(data,"user");
    var body = json.decode(res.body);
    print(res.statusCode);
    if(res.statusCode==200) {
      pr.hide();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserList()),
      );
    }

  }


  Future<bool> notificationDialog(context){
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogNotification(
        title: "Invalid Email",
        description:
        "Please make sure you entered correct email",
        buttonText: "Okay",
//          image: "assets/images/eligible.png"

      ),
    );
  }
}
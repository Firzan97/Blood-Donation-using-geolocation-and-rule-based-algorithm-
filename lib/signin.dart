import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_blood/admin/dashboard/dashboard.dart';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/already_have_account.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_password_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/constant.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/home/home.dart';
import 'package:easy_blood/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'dart:async';
import 'dart:convert';
import 'package:easy_blood/api/api.dart';


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
  var pr;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool dataFilled= false,passwordValidator=false;
  String token1;
  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;
  Channel channel;

  String channelName = 'easy-blood';
  String eventName = "message";

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
//    initPusher();

  }
//  void dispose()
//  {
//    super.dispose();
//    Pusher.unsubscribe(channelName);
//    channel.unbind(eventName);
//    _eventData.close();
//
//  }
  @override
  Widget build(BuildContext context) {
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
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ),
    child:Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height*0.112),
              Center(
                child: Text("LOGIN",style: TextStyle(
                  fontFamily: "Muli",
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: kPrimaryColor

                ),),
              ),
              SizedBox(height: size.height*0.02,),
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
                      onchanged: (value){
                        setState(() {
                          if(email.text!="" && password.text!=""){
                            dataFilled = true;
                          }
                          else{
                            dataFilled = false;
                          }
                        });
                      },
                      validator: (value) =>
                      (value.isEmpty) ? 'Please enter some text' :
                      null,
                    ),

                    InputPasswordRound(
                      controller: password,
                      onchanged: (value){
                        setState(() {
                          if(email.text!="" && password.text!=""){
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
                      textColor: dataFilled!=true  ? Colors.grey : Colors.white ,
                      text: "LOGIN",
                      press: dataFilled!=true ? null : (){
                        if (_formkey.currentState.validate()) {
                          bool isValid = EmailValidator.validate(email.text);
                          if (isValid == false) {
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
                          else if (passwordValidator == false) {
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
                          else {
                            pr.show();
//                              updateName();
                            login();
                          }
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



  Future<void> initPusher() async {
    await Pusher.init(
        DotEnv().env['PUSHER_APP_KEY'],
        PusherOptions(cluster: DotEnv().env['PUSHER_APP_CLUSTER']),
        enableLogging: true
    );

    Pusher.connect();

//    channel = await Pusher.subscribe(channelName);
//
//    channel.bind(eventName, (last) {
//      final String data = last.data;
//      _inEventData.add(data);
//      print("nate cekkpiiiiiiiiiiiiiiiiiiiik");
//
//    });
//
//    eventStream.listen((data) async {
//      setState(() {
//        print("nate babi beruk 3");
//      });
//    });
  }

//  updateName() async{
//    SharedPreferences localStorage = await SharedPreferences.getInstance();
//    var user = jsonDecode(localStorage.getString("user"));
//    var data={
//      "username": "babi",
//    };
//    var res = await Api().updateData(data,"userName/${user['_id']}");
//    print("update nama equal to === " + res.statusCode.toString());
//  }

  Future<bool> infoDialog(context){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("User not found"),
            content: Text("There are no account sign up with this email/password"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }



  Future<void> updateNotificationToken($userid)async{
    var data={
      "notificationToken": token1,
    };
    var res = await Api().updateData(data, "user/${$userid}/notification");
    }

  Future<void> login() async {
    if (_formkey.currentState.validate()) {
    } else {
      print("Could  not sign in. Wrong input ");
    }

    var data={
      "email": email.text,
      "password": password.text
    };


    var res = await Api().postData(data, "login");
    var body = json.decode(res.body);
    if(body['success']){
      initPusher();
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      updateNotificationToken(body["user"]["_id"]);
      var a =localStorage.getString('user');
      if(body["user"]["role"]=="admin"){
        pr.hide();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      }
      else{
//        initPusher();
        updateUserPresence(body["user"]["_id"]);
        pr.hide();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }

    }
    else {
      pr.hide();
      infoDialog(context);
    }
  }

  void updateUserPresence($userid)async{
    var data = {
      "type": "update status",
      "isOnline": true
    };

    var res = await Api().updateData(data, "user/${$userid}");
    if(res.statusCode==200){
      print("status updated");
    }
  }
}

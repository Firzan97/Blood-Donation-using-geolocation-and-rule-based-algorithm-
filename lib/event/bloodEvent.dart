import 'dart:convert';
import 'dart:io';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/event/bloodEventDetail.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/event.dart';
import 'package:easy_blood/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/button_round.dart';
import '../component/input_round.dart';
import 'dart:convert' show JSON;
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:easy_blood/loadingScreen.dart';


import '../component/input_time.dart';

class BloodEvent extends StatefulWidget {
  BloodEvent({Key key}) : super(key: key);

  @override
  _BloodEventState createState() => _BloodEventState();
}

class _BloodEventState extends State<BloodEvent> {
  Future<List<Campaign>> futureEvent;
  File _image;
  final picker = ImagePicker();
  String base64Image;
  File tmpFile;
  String status = "";
  String errMessage = "error Upload Image";
  String uploadEndPoint = "";
  String token1;



  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      tmpFile = _image;
      base64Image = base64Encode(tmpFile.readAsBytesSync());
    });
    print(base64Image);
  }

  @override
  void initState() {
    super.initState();
    futureEvent = fetchEvent();

  }

  TextEditingController eventName = new TextEditingController();
  TextEditingController eventLocation = new TextEditingController();
  TextEditingController eventTime = new TextEditingController();
  TextEditingController eventDate = new TextEditingController();
  TextEditingController eventOrganizer = new TextEditingController();
  TextEditingController eventPhoneNumber = new TextEditingController();
   var dateStart,dateEnd,timeStart,_timeStart,timeEnd,_timeEnd;
  bool _isLoading = false;
  String error = "";
  final _formKey = GlobalKey<FormState>();
  static final Keys1 = GlobalKey();
  static final Keys2 = GlobalKey();
  var pr;
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
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
              child: Scaffold(
                  body: Container(
                      width: size.width * 1,
                      height: size.height * 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: FutureBuilder(
                              future: fetchEvent(),
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                    child: Center(
                                      child: LoadingScreen(),
                                    ),
                                  );
                                }
                                else if(snapshot.data.length==0){
                                  return Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: size.height*0.2,),
                                        Image.asset(
                                            "assets/images/not_found.png"
                                        ),
                                        Text("Currently no event :(",style: TextStyle(
                                          fontSize: size.height*0.033,
                                          fontFamily: "Muli"
                                        ),)
                                      ],
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                        DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                                        var dateStart = dateFormat.format(snapshot.data[index].dateStart);
                                        var currentTime = DateFormat.jm().format(snapshot.data[index].dateStart);
                                         var c = snapshot.data[index].timeStart;


                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: size.height*0.3,
//                                      decoration: BoxDecoration(
//                                          color: Colors.white,
//                                          borderRadius:
//                                              BorderRadius.circular(5.0)),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top:size.height*0.01,
                                            right:size.width*0.01,
                                            child: Container(
                                              width: size.width*0.67,
                                            height: size.height*0.24,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 9,
                                                      spreadRadius: 3,
                                                      color: Colors.black.withOpacity(0.1)
                                                  )
                                                ],
                                        color: Colors.white,
                                        borderRadius:
                                              BorderRadius.circular(5.0)),
                                              child:  Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    SizedBox(width: size.width*0.07,),

                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text("Title",style: TextStyle(
                                                          fontWeight: FontWeight.w700,

                                                      ),),
                                                      Text(snapshot.data[index].name,style: TextStyle(
                                                          fontWeight: FontWeight.w300,
                                                        fontSize: 13
                                                      ),),
                                                      Text("Location",style: TextStyle(
                                                          fontWeight: FontWeight.w700
                                                      ),),
                                                      Text(
                                                    snapshot.data[index].location,style: TextStyle(
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 13
                                                      ),),
                                                      Text("Time",style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                      ),),
                                                      Text(
                                                        snapshot.data[index].timeStart.toString(),style: TextStyle(
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 13
                                                      ),),
                                                      Text("Date",style: TextStyle(
                                                          fontWeight: FontWeight.w700
                                                      ),),
                                                      Text(
                                                        dateStart,style: TextStyle(
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 13
                                                      ),),
                                                    ],
                                            ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BloodEventDetail(
                                                            event: snapshot
                                                                .data[index])),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 9,
                                                    spreadRadius: 3,
                                                    color: Colors.grey.withOpacity(0.2)
                                                  )
                                                ]
                                              ),
                                              child:  ClipRRect(
borderRadius: BorderRadius.circular(25),
                                                  child: Image.network(
                                                    snapshot.data[index].imageURL,
                                                    width: size.width*0.35,
                                                    height: size.height*0.26,
                                                    fit: BoxFit.fill,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                        );
                                  },
                                );

                                // By default, show a loading spinner.
                                return CircularProgressIndicator();
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 10,
                            right: 10,
                            child: Container(
                              width: size.width * 0.9,
                              height: size.height * 0.075,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  color: Color(0xffffbcaf).withOpacity(0.5)),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 5,
                            right: 5,
                            child: Container(
                              width: size.width * 0.9,
                              height: size.height * 0.065,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  color: Color(0xffffbcaf).withOpacity(0.9)),
                            ),
                          ),
                          DraggableScrollableSheet(
                              initialChildSize: 0.05,
                              minChildSize: 0.05,
                              maxChildSize: 0.7,
                              builder: (BuildContext c, s) {
                                return Container(
                                  width: size.width * 1,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color(0xffffbcaf),
                                            kGradient2.withOpacity(0.7)
                                          ]),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: SingleChildScrollView(
                                    controller: s,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Center(child: Text("ADD EVENT")),
                                            Container(
                                              child: Form(
                                                key: _formKey,
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(8.0),
                                                      child: Container(
                                                          height: 40,
                                                          width: size.width * 0.27,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0)),
                                                          child: FlatButton(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            child: Text("Upload",style: TextStyle(
                                                                fontWeight: FontWeight.w700,
                                                                fontFamily: "Muli",
                                                                color: Colors.black
                                                            ),),onPressed: (){
                                                            getImageGallery();
                                                          },
                                                          )),
                                                    ),
                                                    InputRound(
                                                      controller: eventName,
                                                      deco: InputDecoration(
                                                        hintText: "Event Name",
                                                        hintStyle: TextStyle(fontSize: size.width*0.035),
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                          Icons.event_available,
                                                          color: kThirdColor,
                                                        ),
                                                      ),
                                                      validator: (value) => (value
                                                              .isEmpty)
                                                          ? 'Please enter some text'
                                                          : null,
                                                    ),
                                                    InputRound(
                                                      controller: eventLocation,
                                                      deco: InputDecoration(
                                                        hintText: "Location",
                                                        hintStyle: TextStyle(fontSize: size.width*0.035),
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                          Icons.location_on,
                                                          color: kThirdColor,
                                                        ),
                                                      ),
                                                      validator: (value) => (value
                                                              .isEmpty)
                                                          ? 'Please enter some text'
                                                          : null,
                                                    ),
                                                    InputRound(
                                                      controller: eventOrganizer,
                                                      deco: InputDecoration(
                                                        hintText: "Organizer",
                                                        hintStyle: TextStyle(fontSize: size.width*0.035),
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                          Icons.event_available,
                                                          color: kThirdColor,
                                                        ),
                                                      ),
                                                      validator: (value) => (value
                                                              .isEmpty)
                                                          ? 'Please enter some text'
                                                          : null,
                                                    ),
                                                    InputRound(
                                                      controller: eventPhoneNumber,
                                                      deco: InputDecoration(
                                                        hintText: "Phone Number",
                                                        hintStyle: TextStyle(fontSize: size.width*0.035),
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                          Icons.event_available,
                                                          color: kThirdColor,
                                                        ),
                                                      ),
                                                      validator: (value) => (value
                                                              .isEmpty)
                                                          ? 'Please enter some text'
                                                          : null,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                      Container(
                                                      width: 150,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(20)
                                                      ),
                                                      child: FlatButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(20)
                                                          ),
                                                          onPressed: ()async {
                                                            dateStart = await showRoundedDatePicker(
                                                            context: context,
                                                            theme: ThemeData(primarySwatch: Colors.red),
                                                            imageHeader: AssetImage("assets/images/blood.jpg"),
                                                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                                          );
                                                          },
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.date_range),
                                                              Text(
                                                                'Date Start',
                                                                style: TextStyle(color: Colors.black),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                              Container(
                                                width: 150,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: FlatButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20)
                                                    ),
                                                    onPressed: () async{
                                                     dateEnd = await showRoundedDatePicker(
                                                       context: context,
                                                       theme: ThemeData(primarySwatch: Colors.red),
                                                       imageHeader: AssetImage("assets/images/blood.jpg"),
                                                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                                     );
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.date_range),
                                                        Text(
                                                          'Date End',
                                                          style: TextStyle(color: Colors.black),
                                                        ),
                                                      ],
                                                    )),
                                              )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                      Container(
                                                      width: 150,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(20)),
                                                      child: FlatButton(
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                          onPressed: ()async {

                                                          timeStart = await showRoundedTimePicker(
                                                            context: context,
                                                            initialTime: TimeOfDay.now(),
                                                          );
                                                          if(timeStart.hour>=12){
                                                            var time = timeStart.hour-12;
                                                            if(time==0){
                                                              var time = timeStart.hour;
                                                              _timeStart=time.toString()+ ":"+timeStart.minute.toString()+" PM";

                                                            }
                                                            else{
                                                              _timeStart=time.toString()+ ":"+timeStart.minute.toString()+" PM";

                                                            }
                                                          }
                                                          else{
                                                            if(timeStart.hour==0){
                                                              var time = timeStart.hour+12;
                                                              _timeStart=time.toString()+ ":"+timeStart.minute.toString()+" AM";

                                                            }
                                                            else{
                                                              _timeStart=timeStart.hour.toString()+ ":"+timeStart.minute.toString()+" AM";

                                                            }

                                                          }
                                                          },
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.timer),
                                                              Text(
                                                                "Time Start",
                                                                style: TextStyle(color: Colors.black),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                              Container(
                                                width: 150,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20)),
                                                child: FlatButton(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                    onPressed: ()async {

                                                     timeEnd=await showRoundedTimePicker(
                                                       context: context,
                                                       initialTime: TimeOfDay.now(),
                                                     );
                                                     if(timeEnd.hour>=12){
                                                       var time = timeEnd.hour-12;
                                                       if(time==0){
                                                         var time = timeEnd.hour;
                                                         _timeEnd=time.toString()+ ":"+timeEnd.minute.toString()+" PM";

                                                       }
                                                       else{
                                                         _timeEnd=time.toString()+ ":"+timeEnd.minute.toString()+" PM";

                                                       }
                                                     }
                                                     else{
                                                       if(timeEnd.hour==0){
                                                         var time = timeEnd.hour+12;
                                                         _timeEnd=time.toString()+ ":"+timeEnd.minute.toString()+" AM";

                                                       }
                                                       else{
                                                         _timeEnd=timeEnd.hour.toString()+ ":"+timeEnd.minute.toString()+" AM";

                                                       }

                                                     }
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.timer),
                                                        Text(
                                                          "Time End",
                                                          style: TextStyle(color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    ButtonRound(
                                                      color: Color(0XFF343a69),
                                                      text: "CONFIRM",
                                                      press: () async {
                                                        if (_formKey.currentState
                                                            .validate()) {
                                                          pr.show();
                                                          print("Validate");
                                                          addEvent();

                                                        } else {
                                                          error =
                                                              "Could  not sign in. Wrong input ";
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                        ],
                      )))),
    );
  }

  Future<List<Campaign>> fetchEvent() async {

    var res = await Api().getData("event");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Campaign> events = [];
      var count=0;
      for (var u in body) {
        count++;

        Campaign event = Campaign.fromJson(u);
        events.add(event);
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future getQue() async {
    List<String> token=[];
    var res = await Api().getData("user");
    var body = json.decode(res.body);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var user= jsonDecode(userjson);

    if (res.statusCode == 200) {
      var count = 0;
      for (var u in body) {
        print(user["_id"].toString() + "==="+u["_id"].toString());
        if(user["_id"]!=u["id"]){
          var t = u['notificationToken'];
          token.add(t);
        }


      };
    }

    if(token!=null){
      //call php file
      var data={
        "token": token,
      };print(token);
      var res = await Api().postData(data,"notification");
//        return json.decode(res.body);
    }
    else{
      print("Token is null");
    }
  }

  Future<void> addEvent() async {
    if (_formKey.currentState.validate()) {
    } else {
      print("Could added. Wrong input ");
    }
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var user= jsonDecode(userjson);
    var data={
      "image": base64Image,
      "name": eventName.text,
      "location": eventLocation.text,
      "phoneNum": eventPhoneNumber.text,
      "dateStart": dateStart.toString(),
      "dateEnd": dateEnd.toString(),
      "organizer": eventOrganizer.text,
      "timeStart":_timeStart,
      "timeEnd": _timeEnd,
      "imageURL": "assets/images/dermadarah2.jpg",
      "user_id": user["_id"],
    };

    var res = await Api().postData(data, "event");
    print(res.statusCode);
    if(res.statusCode==200){
      getQue();
      pr.hide();
      eventInfoDialog(context);
    }

    }

//  dynamic myEncode(dynamic item) {
//    if(item is DateTime) {
//      return item.toIso8601String();
//    }
//    return item;
//  }

  Future<bool> eventInfoDialog(context){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Event Added"),
            content: Text("Thank you :D"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                },
              )
            ],
          );
        }
    );
  }

//  Future<Map<String, dynamic>> _uploadImage(File image) async{
//    var addressUri= Uri.parse("http://192.168.1.7/api/uplaodimage");
//    SharedPreferences userData = await SharedPreferences.getInstance();
//    print(userData.getString("user"));
//    final memeTypeData = lookupMimeType(image.path, headerBytes: [0xD8]).split('/');
//
//    final imageUploadRequest = http.MultipartRequest('POST',addressUri);
//
//    final file = await http.MultipartFile.fromPath('photo[0]', image.path),
////    contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
//
//
//  }
}
extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
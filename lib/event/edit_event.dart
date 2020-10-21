import 'dart:convert';
import 'dart:io';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/event/bloodEvent.dart';
import 'package:easy_blood/event/bloodEventDetail.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:http/http.dart' as http;

import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditEvent extends StatefulWidget {
  final Event edit;

  EditEvent({Key key, @required this.edit}) : super(key: key);

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {

  TextEditingController eventName = new TextEditingController();
  TextEditingController eventLocation = new TextEditingController();
  TextEditingController eventTime = new TextEditingController();
  TextEditingController eventDate = new TextEditingController();
  TextEditingController eventOrganizer = new TextEditingController();
  TextEditingController eventPhoneNumber = new TextEditingController();

  var dateStart,dateEnd,timeStart,timeEnd;
  final picker = ImagePicker();
  String base64Image;
  File _image;
  File tmpFile;
  String uploadEndPoint = "";
  var user;
  var status ;
  String errMessage = "error Upload Image";
  var pr;

  void getUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(localStorage.getString("user"));
      uploadEndPoint = "http://laraveleasyblood-env.eba-kezjpqpc.ap-southeast-1.elasticbeanstalk.com/api/user/${user['_id']}/event/${widget.edit.id}";
    });
  }

  Future getImage() async {
    var pickedFile;
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      tmpFile = _image;
      base64Image = base64Encode(tmpFile.readAsBytesSync());
    });
  }

  setStatus(var message){
    setState(() {
      status = message;
    });

    print(status);
  }

  upload() async{
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    pref.setString("user", null);
//    var email2=pref.getString("_id");
    var gender;
    http.put(uploadEndPoint, body: {
      "imageURL": base64Image!=null ? base64Image : "" ,
      "name": eventName.text!="" ? eventName.text : widget.edit.name,
      "location":  eventLocation.text!="" ? eventLocation.text : widget.edit.location,
      "organizer":  eventOrganizer.text!="" ?  eventOrganizer.text : widget.edit.organizer,
      "phoneNumber":  eventPhoneNumber.text!="" ? eventPhoneNumber.text : widget.edit.phoneNum,
      "dateStart":  dateStart!=null ? dateStart.toString() : widget.edit.dateStart.toString(),
      "dateEnd":  dateEnd!=null ? dateEnd.toString() : widget.edit.dateEnd.toString(),
      "timeStart":  timeStart!=null ? timeStart.toString() : widget.edit.timeStart.toString(),
      "timeEnd":  timeEnd!=null ? timeEnd.toString() : widget.edit.timeEnd.toString(),

    }).then((result) {
      setStatus(result.statusCode == 200 ? result.statusCode : errMessage);
      pr.hide();
    Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
      MaterialPageRoute(
      builder: (BuildContext context) =>
      BloodEvent()));
    }).catchError((error) {
      setStatus(error);
    });
  }

  @override
  void initState(){
    super.initState();
    getUserData();
  }

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
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [kGradient1.withOpacity(0.7), kGradient2.withOpacity(0.7)]),

          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        height: 240,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .rectangle,
                        ),
                        child: ClipRRect(
                            borderRadius:
                            BorderRadius
                                .circular(
                                5),
                            child: Image
                                .network(
                              widget.edit.imageURL,
                              fit: BoxFit
                                  .cover,)),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(

                          color: kGradient2
                      ),
                      child: FlatButton(
                        onPressed: (){
                          getImage();
                        },
                        child: Center(
                          child: Text("Change Picture",
                            style: TextStyle(
                                fontWeight: FontWeight
                                    .w700,
                                fontFamily: "Muli",
                                color: Colors.white
                            ),),
                        ),
                      ),
                    ),
                  ),
                  Text("Name"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.withOpacity(0.1))
                        ),

                      child: TextField(
                      controller: eventName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: widget.edit.name),
                      ),
                    ),
                  ),
                  Text("Location"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.withOpacity(0.1))
                      ),

                      child: TextField(
                      controller: eventLocation,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: widget.edit.location),
                      ),
                    ),
                  ),
                  Text("Organizer"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.withOpacity(0.1))
                      ),

                      child: TextField(
                      controller: eventOrganizer,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: widget.edit.organizer),
                      ),
                    ),
                  ),
                  Text("PhoneNumber"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.withOpacity(0.1))
                      ),

                      child: TextField(
                      controller: eventPhoneNumber,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: widget.edit.phoneNum),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: size.width*0.31,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(2020, 3, 5),
                                            maxTime: DateTime(2029, 6, 7),
                                            theme: DatePickerTheme(
                                                headerColor: kPrimaryColor,
                                                backgroundColor: kThirdColor,
                                                itemStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                                            onChanged: (date) {
                                              print('change $date in time zone ' +
                                                  date.timeZoneOffset.inHours.toString());
                                            }, onConfirm: (date) {
                                              dateStart = date;
                                              print('confirm ${date}');
                                            }, currentTime: DateTime.now(), locale: LocaleType.en);
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
                                  width: size.width*0.31,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(2020, 3, 5),
                                            maxTime: DateTime(2029, 6, 7),
                                            theme: DatePickerTheme(
                                                headerColor: kPrimaryColor,
                                                backgroundColor: kThirdColor,
                                                itemStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                                            onChanged: (date) {
                                              print('change $date in time zone ' +
                                                  date.timeZoneOffset.inHours.toString());
                                            }, onConfirm: (date) {
                                              dateEnd = date;
                                              print('confirm ${date}');
                                            }, currentTime: DateTime.now(), locale: LocaleType.en);
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
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: size.width*0.31,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      onPressed: () {

                                        DatePicker.showTime12hPicker(context,
                                            theme: DatePickerTheme(
                                                headerColor: kGradient1,
                                                backgroundColor: Colors.white,
                                                itemStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
                                            showTitleActions: true, onChanged: (time) {
                                              print('change $time in time zone ' +
                                                  time.timeZoneOffset.inHours.toString());
                                            }, onConfirm: (time) {
                                              timeStart=time;
                                              print('confirm $time');
                                            }, currentTime: DateTime.now());
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
                                  width: size.width*0.31,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      onPressed: () {

                                        DatePicker.showTime12hPicker(context,
                                            theme: DatePickerTheme(
                                                headerColor: kGradient1,
                                                backgroundColor: Colors.white,
                                                itemStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
                                            showTitleActions: true, onChanged: (time) {
                                              print('change $time in time zone ' +
                                                  time.timeZoneOffset.inHours.toString());
                                            }, onConfirm: (time) {
                                              timeEnd=time;
                                              print('confirm $time');
                                            }, currentTime: DateTime.now());
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.timer),
                                          Text(
                                            "Time End",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        height: 50,
                        width: size.width*0.6,
                        decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                            color: kGradient2,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 3,
                              color: kPrimaryColor.withOpacity(0.3),
                              blurRadius: 6
                            )
                          ]
                        ),
                        child: FlatButton(
                          onPressed: (){
                            pr.show();
                            upload();
                    
                          },
                          child: Center(
                            child: Text("Save Changed",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  fontFamily: "Muli",
                                  color: Colors.white
                              ),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

}

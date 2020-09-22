import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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


  @override
  Widget build(BuildContext context) {
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
                  Text("Name"),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.withOpacity(0.1))
                      ),

                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
//                      controller: _mobileController,
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
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.withOpacity(0.1))
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
//                      controller: _mobileController,
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
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.withOpacity(0.1))
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
//                      controller: _mobileController,
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
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.withOpacity(0.1))
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
//                      controller: _mobileController,
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
                                  width: size.width*0.4,
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
                                  width: size.width*0.4,
                                  height: size.,
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
                                  width: 150,
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
                                  width: 150,
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

                  Center(
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
                ],
              ),
            ),
          ),
        ),
    );
  }
}

import 'package:easy_blood/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditEvent extends StatefulWidget {
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
                                .asset(
                              "assets/images/lari2.jpg",
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
                            border: InputBorder.none,
                            hintText: 'Enter Name'),
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
                            border: InputBorder.none,
                            hintText: 'Enter Location'),
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
                            border: InputBorder.none,
                            hintText: 'Enter Organizer'),
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
                            border: InputBorder.none,
                            hintText: 'Enter phone number'),
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
                                Text("Date End"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Time Start"),
                                Text("Time End"),
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

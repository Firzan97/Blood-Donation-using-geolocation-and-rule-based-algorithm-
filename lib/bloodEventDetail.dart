import 'package:easy_blood/constant.dart';
import 'package:easy_blood/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BloodEventDetail extends StatelessWidget {
  final Event event;

  const BloodEventDetail({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        home: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height*0.96,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(event.imageURL),
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                    initialChildSize: 0.05,
                    minChildSize: 0.05,
                    maxChildSize: 0.7,
                    builder: (BuildContext c, s) {
                      return Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 9)
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: SingleChildScrollView(
                          controller: s,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Details",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: size.height*0.62,
                                  decoration: BoxDecoration(
                                   color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 9)
                                    ],
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        event.name,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Date",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Icon(Icons.calendar_today),
                                                        ),
                                                        SizedBox(width: size.width*0.01,),

                                                        Text(dateFormat.format(event.dateStart),style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.white
                                                        ),)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Time",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Icon(Icons.timer),
                                                        ),
                                                        SizedBox(width: size.width*0.01,),

                                                        Text(DateFormat.jm().format(event.dateStart),style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.white
                                                        ),)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Location",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Icon(Icons.location_on),
                                                        ),
                                                        SizedBox(width: size.width*0.01,),

                                                        Text(event.location,style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.white
                                                        ),)                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Description",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left:15.0,right: 15.0,bottom: 15.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 12,
                                                    spreadRadius: 3)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:15.0,right: 15.0,bottom: 15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Text(
                                                  "Sebuah kempen dermah darah yang akan diadakan di perak"
                                                  "hasil kerjasam hospital kedah dan organisai2 lain. Semua dialu- alukan",
                                                  style:
                                                      TextStyle(wordSpacing: 1, color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: kGradient1,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: FlatButton(
                                          onPressed: () {},
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            "Gonna Join",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

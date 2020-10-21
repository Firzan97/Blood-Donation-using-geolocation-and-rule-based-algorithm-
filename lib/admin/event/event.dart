import 'dart:async';
import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/event/bloodEventDetail.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/event.dart';
import 'package:easy_blood/test.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<Event> events = [];
  int incomingEvent,eventToday;
  var pr;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
        theme: ThemeData(
          fontFamily: "Muli",
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("EASY BLOOD")),
            elevation: 0,
            backgroundColor: kPrimaryColor,
          ),
          body: Container(
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      Container(
                        width: size.width*1,
                        height: size.height * 0.3,
                        decoration: BoxDecoration(color: kPrimaryColor),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: size.height * 0.18,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Image.asset("assets/images/doctor.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Container(
                                width: size.width*0.96,
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 9,
                                          spreadRadius: 7
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: <Widget>[Container(
                                    child: FlatButton(
                                      child: Column(
                                        children: <Widget>[
                                          Text("Incoming Event", style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width*0.033
                                          ),),
                                          Text(events.length.toString(),style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width*0.033
                                          ))
                                        ],
                                      ),
                                      onPressed: () {

                                      },
                                    ),

                                  ),
                                    Container(
                                      child: FlatButton(
                                        child: Column(
                                          children: <Widget>[
                                            Text("Event Today",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: size.width*0.033
                                              ),),
                                            Text("2",style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.width*0.033
                                            ))
                                          ],
                                        ),
                                        onPressed: () {

                                        },
                                      ),
                                    ),
                                    Container(
                                      child: FlatButton(
                                        child: Column(
                                          children: <Widget>[
                                            Text("Total Event",style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.width*0.033
                                            ),),
                                            Text(events.length.toString(),style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.width*0.033
                                            ))
                                          ],
                                        ),
                                        onPressed: () {

                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.height*0.7,
                        child: FutureBuilder(
                            future: fetchTotalEvent(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                    child: LoadingScreen(),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 3,
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 9
                                              )
                                            ]
                                        ),
                                        height: size.height*0.6,
                                        child: ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context, int index){
                                              DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                                              String dateStart = dateFormat.format(snapshot.data[index].timeStart);
                                              dynamic currentTime = DateFormat.jm().format(snapshot.data[index].timeStart);


                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
//                                      decoration: BoxDecoration(
//                                          color: Colors.white,
//                                          borderRadius:
//                                              BorderRadius.circular(5.0)),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Positioned(
                                                        top:10,
                                                        right:20,
                                                        child: Container(
                                                          width: 280,
                                                          height: 184,
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
                                                                SizedBox(width: size.width*0.11,),

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
                                                                      currentTime,style: TextStyle(
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
                                                                width: 140,
                                                                height: 200,
                                                                fit: BoxFit.fill,
                                                              )),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        right: 15,
                                                        child:    Row(
                                                          children: <Widget>[
                                                            IconButton(icon: Icon(Icons.delete_forever,color: Colors.black,),
                                                              onPressed: (){
                                                                _eventDeleteDialog(snapshot.data[index].id);
                                                              },),
                                                            IconButton(icon: Icon(Icons.edit,color: Colors.black,))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ])),
          ),
        ));
  }

  Future<bool> _eventDeleteDialog(eventId) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Delete Event')),
          content: Text('Confirm to delete this event?'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); //Will not exit the App
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
                _deleteEvent(eventId);
              },
            )
          ],
        );
      },
    ) ?? false;
  }

  _deleteEvent(eventId) async{
    var res = await Api().deleteData("event/${eventId}");
    if (res.statusCode == 200){
      pr.show();
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EventList()),
        );
        pr.hide();
      });

    }
  }

  Future<List<Event>> fetchTotalEvent() async {
    events=[];
    DateTime now = new DateTime.now();

    var res = await Api().getData("event");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      var count = 0;
      for (var u in body) {
        Event event = Event.fromJson(u);
        print(event.dateStart);
        setState(() {
          events.add(event);
        });
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Event>> fetchIncomingEvent() async {
    events=[];
    var res = await Api().getData("IncomingEvent");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      var count = 0;
      for (var u in body) {
        Event event = Event.fromJson(u);
        setState(() {
          events.add(event);
        });
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<List<Event>> fetchNewEvent() async {
    events=[];
    var res = await Api().getData("Todayevent");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      var count = 0;
      for (var u in body) {
        Event event = Event.fromJson(u);
        setState(() {
          events.add(event);
        });
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }

}

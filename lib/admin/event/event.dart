import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/event.dart';
import 'package:flutter/material.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  List<Event> events = [];
  var totalEvent;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                        height: size.height * 0.3,
                        decoration: BoxDecoration(color: kPrimaryColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: size.height * 0.18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Image.asset("assets/images/doctor.png"),
                              ),
                              Container(
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
                                          Text("Total Request", style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13
                                          ),),
                                          Text(totalEvent.toString())
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
                                            Text("New Request Today",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13

                                              ),),
                                            Text("2")
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
                                            Text("Total Admin", style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13

                                            ),),
                                            Text("1")
                                          ],
                                        ),
                                        onPressed: () {

                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: size.height*0.7,
                        child: FutureBuilder(
                            future: fetchUser(),
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
                                              return Column(
                                                children: <Widget>[
                                                  Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  height: size.height * 0.08,
                                                                  width: size.width * 0.18,
                                                                  decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image: NetworkImage(
                                                                          snapshot.data[index].location,),
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius.circular(2)),
                                                                ),
                                                                SizedBox(width: size.width*0.03,),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      snapshot.data[index].bloodType,
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 14),
                                                                    ),
                                                                    Text(
                                                                      snapshot.data[index].reason,
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 13),
                                                                    ),

                                                                  ],
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            snapshot.data[index].bloodType,
                                                            style:
                                                            TextStyle(color: kPrimaryColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
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

  Future<List<Event>> fetchUser() async {
    var res = await Api().getData("request");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      var count = 0;
      for (var u in body) {
        Event request = Event.fromJson(u);
        events.add(request);
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }

}

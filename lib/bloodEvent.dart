import 'dart:convert';

import 'package:easy_blood/addBloodEvent.dart';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/bloodEventDetail.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/home.dart';
import 'package:easy_blood/model/album.dart';
import 'package:easy_blood/model/event.dart';
import 'package:easy_blood/userdashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BloodEvent extends StatefulWidget {
  BloodEvent({Key key}) : super(key: key);

  @override
  _BloodEventState createState() => _BloodEventState();
}

class _BloodEventState extends State<BloodEvent> {
  Future<List<Event>> futureEvent;

  @override
  void initState() {
    super.initState();
    futureEvent = fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  backgroundColor: kGradient2,
                  expandedHeight: 150,
                  floating: true,
                  pinned: true,
                  flexibleSpace: ClipPath(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [kGradient1, kGradient2]),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color:kThirdColor,
                                  borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    spreadRadius:3,
                                    blurRadius: 7
                                  )
                                ]
                              ),
                              child: FlatButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddBloodEvent()),
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Icon(Icons.add,color: Colors.white,),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              SliverFillRemaining(
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                  child: FutureBuilder(
                    future: fetchEvent(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                            child: Text("Loading..."),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.black.withOpacity(0.1),
                            ),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BloodEventDetail(
                                                  event: snapshot.data[index])),
                                    );
                                  });
                                },
                                child: ListTile(
                                  leading: Image.asset(
                                      "assets/images/dermadarah1.jpg"),
                                  title: Text(snapshot.data[index].name),
                                  isThreeLine: true,
                                  subtitle: Text(snapshot.data[index].location),
                                ),
                              );
                            },
                          ),
                        ),
                      );

                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Event>> fetchEvent() async {
    var res = await Api().getData("event");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Event> events = [];
      for (var u in body) {
        Event event = Event(u["name"], u["location"]);
        events.add(event);
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

import 'dart:convert';

import 'package:easy_blood/addBloodEvent.dart';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/bloodEventDetail.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/model/album.dart';
import 'package:easy_blood/model/event.dart';
import 'package:easy_blood/userdashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BloodEvent extends StatefulWidget {
  BloodEvent({Key key}) : super(key: key);

  @override
  _BloodEventState createState() => _BloodEventState();
}

class _BloodEventState extends State<BloodEvent> {
Future<List<Event>> futureEvent;

  @override
  void initState(){
    super.initState();
    futureEvent = fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFd50000),
                        kPrimaryColor,
                      ]),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserDashboard()),
                              );
                            },
                          ),
                          SizedBox(width: size.width * 0.30),
                          Text("EVENT LIST"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddBloodEvent()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 35.0,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            Expanded(
              child: Container(
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
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BloodEventDetail(event: snapshot.data[index])),
                              );
                            });
                          },
                          child: ListTile(
                              title: Text(snapshot.data[index].name),
                              subtitle: Text(snapshot.data[index].location),
                          ),
                        );
                      },
                    );

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<List<Event>> fetchEvent() async
  {
    var res = await Api().getData("event");
    var body = json.decode(res.body);
    if(res.statusCode == 200){
      List<Event> events = [];
      for(var u in body){
        Event event = Event(u["name"], u["location"]);
        events.add(event);
      }

      return events;
    }
    else{
      throw Exception('Failed to load album');
    }
  }
}

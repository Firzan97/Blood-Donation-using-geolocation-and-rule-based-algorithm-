import 'dart:async';
import 'dart:convert';
import 'package:easy_blood/about.dart';
import 'package:easy_blood/addBloodEvent.dart';
import 'package:easy_blood/bloodRequest.dart';
import 'package:easy_blood/datetime.dart';
import 'package:easy_blood/home.dart';
import 'package:easy_blood/signin.dart';
import 'package:easy_blood/model/event.dart';
import 'package:easy_blood/signup.dart';
import 'package:easy_blood/timelime.dart';
import 'package:easy_blood/userdashboard.dart';
import 'package:easy_blood/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Event> fetchAlbum() async {
  final response =
  await http.get("http://192.168.1.7:8000/event");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    EventList eventlist = EventList.fromJson(json.decode(response.body));
    return eventlist.events[0];
//    return Event.fromJson(json.decode(response.body));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Event> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: AddBloodEvent(),
//        Center(
//          child: FutureBuilder<Event>(
//            future: futureAlbum,
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                return Text(snapshot.data.name);
//              } else if (snapshot.hasError) {
//                return Text("${snapshot.error}");
//              }
//
//              // By default, show a loading spinner.
//              return CircularProgressIndicator();
//            },
//          ),
//        ),
      ),
    );
  }
}
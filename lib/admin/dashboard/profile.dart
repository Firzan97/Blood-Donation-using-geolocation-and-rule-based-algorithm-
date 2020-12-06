import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/event/edit_event.dart';
import 'package:easy_blood/home/home.dart';
import 'package:easy_blood/model/donation.dart';
import 'package:easy_blood/model/qualification.dart';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/admin/dashboard/edit_profile.dart';
import 'package:easy_blood/welcome/requirement.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/curvedBackground.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/event.dart';
import 'package:easy_blood/model/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:easy_blood/admin/dashboard/dashboard.dart';
class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<List<Requestor>> _futureRequest;
  Future<List<Requestor>> _futureDonation;
  Future<List<Event>> _futureEvent;
  var pr;
  var user;
  String time;
  String lastDonate="d";
  String bloodDonated = "0";
  String bloodRequested = "0";

  void getUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(localStorage.getString("user"));
    });
    print(user['created_at']);
  }

  @override
  void initState() {
    super.initState();
    fetchLastDonation();
    getUserData();
    _setBloodDonated();
    _futureRequest = fetchRequest();
    _futureDonation = fetchRequest();
    _futureEvent = fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      DateTime dateTime = DateTime.parse(user['created_at']);
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      time = dateFormat.format(dateTime);
    }
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
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
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            fontFamily: "Muli"),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w600,
            fontFamily: "Muli"));
    Size size = MediaQuery.of(context).size;
    return user == null
        ? LoadingScreen()
        : AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          theme: ThemeData(fontFamily: "Muli"),
          home: Scaffold(
            body: Container(
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                children: <Widget>[
                  Container(
                    height: size.height * 1,
                    child: Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: MyClipper2(),
                          child: Container(
                            height: size.height * 0.42,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [kGradient2, kGradient1]),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 12,
                                      spreadRadius: 3,
                                      color: Colors.black.withOpacity(0.9))
                                ]),
                          ),
                        ),
                        Positioned(
                            left: 80,
                            top: 15,
                            child: Image.asset(
                                ("assets/images/bloodPlatelet2.png"))),
                        Container(
                          height: size.height * 1,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,

                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Dashboard()),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfile()),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Container(
                                    height: 80,
                                    child: Stack(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: user == null
                                                          ? NetworkImage(
                                                          'https://easy-blood.s3-ap-southeast-1.amazonaws.com/loadingProfileImage.png')
                                                          : NetworkImage(user[
                                                      'imageURL']))),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(user[
                                'username'].toString()),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Joined ${Jiffy(time).fromNow()}",
                                        // 7 years ago

                                        style: TextStyle(
                                            color: Colors.black
                                                .withOpacity(0.5),
                                            fontSize: size.width * 0.031),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.location_on,
                                          size: size.width * 0.06),
                                      Text("Tumpat, Kelantan",
                                          style: TextStyle(
                                              fontSize:
                                              size.width * 0.031))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.045,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: size.width * 1,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.2),
                                              blurRadius: 9,
                                              spreadRadius: 3)
                                        ],
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                              0.1),
                                                          width: 1.0))),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                4.0,
                                                                horizontal:
                                                                8),
                                                            child: Icon(
                                                              FontAwesomeIcons
                                                                  .passport,
                                                              size:
                                                              size.width *
                                                                  0.06,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Username",
                                                            style: TextStyle(
                                                                fontSize: size
                                                                    .width *
                                                                    0.031),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        user["username"] ==
                                                            null
                                                            ? "s"
                                                            : user[
                                                        "username"],
                                                        style: TextStyle(
                                                            fontSize:
                                                            size.width *
                                                                0.031),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    size.height * 0.02,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                              0.1),
                                                          width: 1.0))),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                4.0,
                                                                horizontal:
                                                                8),
                                                            child: Icon(
                                                              FontAwesomeIcons
                                                                  .genderless,
                                                              size:
                                                              size.width *
                                                                  0.06,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Gender",
                                                            style: TextStyle(
                                                                fontSize: size
                                                                    .width *
                                                                    0.031),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        user["gender"] ==
                                                            null
                                                            ? ""
                                                            : user[
                                                        "gender"],
                                                        style: TextStyle(
                                                            fontSize:
                                                            size.width *
                                                                0.031),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    size.height * 0.02,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                              0.1),
                                                          width: 1.0))),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                4.0,
                                                                horizontal:
                                                                8),
                                                            child: Icon(
                                                              Icons.email,
                                                              size:
                                                              size.width *
                                                                  0.06,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Email",
                                                            style: TextStyle(
                                                                fontSize: size
                                                                    .width *
                                                                    0.031),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        user["email"] ==
                                                            null
                                                            ? "s"
                                                            : user["email"],
                                                        style: TextStyle(
                                                            fontSize:
                                                            size.width *
                                                                0.031),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    size.height * 0.02,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                              0.1),
                                                          width: 1.0))),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                4.0,
                                                                horizontal:
                                                                8),
                                                            child: Icon(
                                                              Icons.person,
                                                              size:
                                                              size.width *
                                                                  0.06,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Age",
                                                            style: TextStyle(
                                                                fontSize: size
                                                                    .width *
                                                                    0.031),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        user["age"] == null
                                                            ? "s"
                                                            : user["age"],
                                                        style: TextStyle(
                                                            fontSize:
                                                            size.width *
                                                                0.031),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    size.height * 0.02,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                              0.1),
                                                          width: 1.0))),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                4.0,
                                                                horizontal:
                                                                8),
                                                            child: Icon(
                                                              Icons.phone,
                                                              size:
                                                              size.width *
                                                                  0.06,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Mobile Number",
                                                            style: TextStyle(
                                                                fontSize: size
                                                                    .width *
                                                                    0.031),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        user["phoneNumber"] ==
                                                            null
                                                            ? ""
                                                            : user[
                                                        "phoneNumber"],
                                                        style: TextStyle(
                                                            fontSize:
                                                            size.width *
                                                                0.031),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    size.height * 0.02,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _setBloodDonated() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("user/${user["_id"]}/request");
    if (res.statusCode == 200) {
      var bodys = json.decode(res.body);
      setState(() {
        bloodDonated = bodys.length.toString();
      });
    }
  }

  Future<bool> _DeleteDialog(Id, activity) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Delete ${activity}')),
          content: Text('Confirm to delete ${activity}?'),
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
                _deleteEvent(Id);
              },
            )
          ],
        );
      },
    ) ??
        false;
  }

  _deleteEvent(eventId) async {
    var res = await Api().deleteData("event/${eventId}");
    if (res.statusCode == 200) {
      pr.show();
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
        pr.hide();
      });
    }
  }

  Future<List<Requestor>> fetchRequest() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("request");
    var bodys = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Requestor> requests = [];
      var count = 0;
      for (Map u in bodys) {
        print(user);
        Requestor req = Requestor.fromJson(u);
        if (user['_id'] == req.user.id) {
          requests.add(req);
        }
      }

      return requests;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Event>> fetchEvent() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("event");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Event> events = [];
      for (Map u in body) {
        Event event = Event.fromJson(u);
        if (user['_id'] == event.user_id) {
          events.add(event);
        }
      }
      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }

  void fetchLastDonation() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("${user["_id"]}/qualification");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {

      Qualification qualification = Qualification.fromJson(body);
      DateTime dateTime = DateTime.parse(qualification.lastDonation.toString());
      final date2 = DateTime.now();
      final difference = date2.difference(qualification.lastDonation).inDays;
      setState(() {
        lastDonate=difference.toString();
      });
    } else {
      throw Exception('Failed to load album');
    }
  }
//  Future<List<Donation>> fetchDonation() async {
//    SharedPreferences localStorage = await SharedPreferences.getInstance();
//    var user = jsonDecode(localStorage.getString("user"));
//    var res = await Api().getData("${user['_id']}/donation");
//    var body = json.decode(res.body);
//    if (res.statusCode == 200) {
//      List<Donation> donations = [];
//      for (Map u in body) {
//        Donation donation = Donation.fromJson(u);
//        donations.add(donation);
//      }
//
//      return donations;
//    } else {
//      throw Exception('Failed to load album');
//    }
//  }
}

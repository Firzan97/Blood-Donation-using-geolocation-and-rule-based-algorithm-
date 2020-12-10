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
import 'package:easy_blood/profile/edit_profile.dart';
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
import 'package:easy_blood/profile/compatible_donor.dart';
class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<List<Requestor>> _futureRequest;
  Future<List<Requestor>> _futureDonation;
  Future<List<Campaign>> _futureEvent;
  Future<List<User>> _futureLiveSaved;

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
      _futureLiveSaved = _lifeSaved(user);

    });
    print(user['created_at']);
  }

  @override
  void initState() {
    super.initState();
    fetchLastDonation();
    getUserData();
    _setBloodDonated();
    setState(() {
      _futureRequest = fetchRequest();
      _futureDonation = fetchRequest();
      _futureEvent = fetchEvent();
    });

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
            child: Scaffold(
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
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      kGradient1.withOpacity(0.9),
                                      kGradient2.withOpacity(0.5)
                                    ]),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: size.height*0.04),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home()),
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                Container(
                                                  height: size.height * 0.05,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          11.00),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            spreadRadius: 2,
                                                            blurRadius: 5,
                                                            color: Colors.black
                                                                .withOpacity(0.3))
                                                      ]),
                                                  child: FlatButton(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.library_books,
                                                          color: Colors.white,
                                                          size: size.width*0.05,
                                                        ),
                                                        Text(
                                                          "Update qualification",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: size.width*0.031),
                                                        )
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => RequirementForm()),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
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
                                          Container(
                                              height: size.height * 0.04,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: kPrimaryColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        spreadRadius: 1,
                                                        blurRadius: 12)
                                                  ]),
                                              child: FlatButton(
                                                onPressed: () {},
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                    user["bloodType"] == null
                                                        ? "Not set"
                                                        : user["bloodType"],
                                                    style: TextStyle(
                                                        fontSize: size.width *
                                                            0.031)),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 9,
                                                  spreadRadius: 3,
                                                  color: Colors.black
                                                      .withOpacity(0.1))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      bloodDonated,
                                                      style: TextStyle(
                                                          fontSize: size.width *
                                                              0.031),
                                                    ),
                                                    Text(
                                                      "Blood donated",
                                                      style: TextStyle(
                                                          fontSize: size.width *
                                                              0.031),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    bloodDonated,
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.031),
                                                  ),
                                                  Text(
                                                    "Blood Requested",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.031),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    "${lastDonate} days ago",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.031),
                                                  ),
                                                  Text(
                                                    "Last Donation",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.031),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
                                                                    Icons.brush,
                                                                    size: size
                                                                            .width *
                                                                        0.06),
                                                              ),
                                                              Text(
                                                                "Height",
                                                                style: TextStyle(
                                                                    fontSize: size
                                                                            .width *
                                                                        0.031),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            user["height"] ==
                                                                    null
                                                                ? ""
                                                                : "${user["height"]} CM",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.width *
                                                                        0.031),
                                                          )
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
                                                  decoration: BoxDecoration(),
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
                                                                    Icons
                                                                        .line_weight,
                                                                    size: size
                                                                            .width *
                                                                        0.06),
                                                              ),
                                                              Text(
                                                                "Weight",
                                                                style: TextStyle(
                                                                    fontSize: size
                                                                            .width *
                                                                        0.031),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            user["weight"] ==
                                                                    null
                                                                ? ""
                                                                : "${user["weight"]} KG",
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
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DraggableScrollableSheet(
                                initialChildSize: 0.05,
                                minChildSize: 0.05,
                                maxChildSize: 0.8,
                                builder: (BuildContext c, s) {
                                  return Container(
                                    height: size.height * 0.2,
                                    width: size.width * 1,
                                    decoration: BoxDecoration(
                                        color: kGradient1.withOpacity(0.3),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 7,
                                              spreadRadius: 4)
                                        ]),
                                    child: SingleChildScrollView(
                                      controller: s,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: size.height * 0.007),
                                          Container(
                                            height: 30,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black),
                                            child: Center(
                                              child: Text(
                                                "Your Activities",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Muli",
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(19.0),
                                            child: Container(
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    width: size.width * 1,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.1),
                                                              spreadRadius: 3,
                                                              blurRadius: 12)
                                                        ]),
                                                    child: Column(
                                                      children: <Widget>[
                                                        FutureBuilder(
                                                            future:
                                                            _futureLiveSaved,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .data ==
                                                                  null) {
                                                                return Container(
                                                                  child: Center(
                                                                    child:
                                                                        LoadingScreen(),
                                                                  ),
                                                                );
                                                              }
                                                              return Container(
                                                                height:
                                                                    size.height *
                                                                        0.4,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: snapshot
                                                                            .data
                                                                            .length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(15.0),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  height: 50,
                                                                                  width: 60,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.rectangle,
                                                                                  ),
                                                                                  child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                      child: Image.network(
                                                                                        snapshot.data[index].imageURL,
                                                                                        fit: BoxFit.cover,
                                                                                      )),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: size.width * 0.09,
                                                                                ),
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Text("6 hours ago"),
                                                                                    Row(
                                                                                      children: <Widget>[
                                                                                        Container(
                                                                                          child: Text(snapshot.data[index].username),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: size.width * 0.08,
                                                                                        ),
                                                                                        Container(
                                                                                          child: Row(
                                                                                            children: <Widget>[
                                                                                              Row(
                                                                                                children: <Widget>[
                                                                                                  Icon(Icons.thumb_up),
                                                                                                  Text("1")
                                                                                                ],
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: size.width * 0.05,
                                                                                              ),
                                                                                              Row(
                                                                                                children: <Widget>[
                                                                                                  Icon(Icons.comment),
                                                                                                  Text("1")
                                                                                                ],
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: size.height*0.05,
                                                    width: size.width*0.34,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: kGradient2),
                                                    child: Center(
                                                      child: Text(
                                                        "Life Saved",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily: "Muli",
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(19.0),
                                            child: Container(
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    width: size.width * 1,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.1),
                                                              spreadRadius: 3,
                                                              blurRadius: 12)
                                                        ]),
                                                    child: Column(
                                                      children: <Widget>[
                                                        FutureBuilder(
                                                            future:
                                                                _futureRequest,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .data ==
                                                                  null) {
                                                                return Container(
                                                                  height:
                                                                      size.height *
                                                                          0.4,
                                                                  child: Center(
                                                                    child:
                                                                        LoadingScreen(),
                                                                  ),
                                                                );
                                                              }
                                                              return Container(
                                                                height:
                                                                    size.height *
                                                                        0.4,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: snapshot
                                                                            .data
                                                                            .length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 15.0),
                                                                            child:
                                                                                Container(

                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                              children: <Widget>[
                                                                                      Container(
                                                                                        height: 50,
                                                                                        width: 60,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.rectangle,
                                                                                        ),
                                                                                        child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                            child: Image.asset(
                                                                                              "assets/images/lari2.jpg",
                                                                                              fit: BoxFit.cover,
                                                                                            )),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: size.width * 0.05,
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: <Widget>[
                                                                                          SizedBox(
                                                                                            height: size.height * 0.02,
                                                                                          ),
                                                                                          Text("6 hours ago"),
                                                                                          Row(
                                                                                            children: <Widget>[
                                                                                              Container(
                                                                                                child: Text("Syazwan Asraf"),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: size.width * 0.08,
                                                                                              ),
                                                                                              Container(
                                                                                                child: Row(
                                                                                                  children: <Widget>[
                                                                                                    IconButton(
                                                                                                      onPressed: () {
                                                                                                        _DeleteDialog(snapshot.data[index].id, 'event');
                                                                                                      },
                                                                                                      icon: Icon(
                                                                                                        Icons.edit,
                                                                                                      ),
                                                                                                    ),
                                                                                                    IconButton(
                                                                                                      icon: Icon(Icons.delete_forever),
                                                                                                      onPressed: () {
                                                                                                        print(snapshot.data[index].id);
                                                                                                        _DeleteDialog(snapshot.data[index].id, 'request');
                                                                                                      },
                                                                                                    )
                                                                                                  ],
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          ),


                                                                                        ],
                                                                                      )
                                                                              ],
                                                                            ),

                                                                                      Container(
                                                                                        height: size.height*0.04,
                                                                                        decoration: BoxDecoration(
                                                                                          color: kPrimaryColor,
                                                                                          borderRadius: BorderRadius.circular(5),
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.black.withOpacity(0.1),
                                                                                              blurRadius: 3,
                                                                                              spreadRadius: 5
                                                                                            )
                                                                                          ]
                                                                                        ),
                                                                                        child: FlatButton(
                                                                                          child: Text("Compatible Donor"),
                                                                                          onPressed: (){
                                                                                            Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                  builder: (context) =>
                                                                                                      CompatibleDonor(bloodType: snapshot.data[index].bloodType,requestId: snapshot.data[index].id)),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                          );
                                                                        }),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: size.height*0.05,
                                                    width: size.width*0.34,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: kGradient2),
                                                    child: Center(
                                                      child: Text(
                                                        "Your Requests",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily: "Muli",
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(19.0),
                                            child: Container(
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    width: size.width * 1,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.1),
                                                              spreadRadius: 3,
                                                              blurRadius: 12)
                                                        ]),
                                                    child: Column(
                                                      children: <Widget>[
                                                        FutureBuilder(
                                                            future:
                                                                _futureEvent,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .data ==
                                                                  null) {
                                                                return Container(
                                                                  child: Center(
                                                                    child:
                                                                        LoadingScreen(),
                                                                  ),
                                                                );
                                                              }
                                                              return Container(
                                                                height:
                                                                    size.height *
                                                                        0.4,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: snapshot
                                                                            .data
                                                                            .length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          var datetime = DateTime.parse(snapshot
                                                                              .data[index]
                                                                              .created_at);
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(15.0),
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  height: 90,
                                                                                  width: 60,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.rectangle,
                                                                                  ),
                                                                                  child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                      child: Image.network(
                                                                                        snapshot.data[index].imageURL,
                                                                                        fit: BoxFit.cover,
                                                                                      )),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: size.width * 0.04,
                                                                                ),
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Text(snapshot.data[index].name),
                                                                                    Row(
                                                                                      children: <Widget>[
                                                                                        Container(child: Text("${timeago.format(datetime)}")),
                                                                                        SizedBox(
                                                                                          width: size.width * 0.05,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Container(
                                                                                      child: Row(
                                                                                        children: <Widget>[
                                                                                          IconButton(
                                                                                            icon: Icon(Icons.edit, color: Colors.black),
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);

                                                                                              Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(builder: (context) => EditEvent(edit: snapshot.data[index])),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                          IconButton(
                                                                                            icon: Icon(
                                                                                              Icons.delete_forever,
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              _DeleteDialog(snapshot.data[index].id, 'event');
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: size.height*0.05,
                                                    width: size.width*0.34,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: kGradient2),
                                                    child: Center(
                                                      child: Text(
                                                        "Event Added",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily: "Muli",
                                                            color:
                                                                Colors.white),
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
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
  }

  Future<void> _setBloodDonated() async {
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
                    if(activity=="request"){
                      _deleteRequest(Id);
                    }
                    else{
                      _deleteEvent(Id);

                    }
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }

  _deleteRequest(requestId) async {
    var res = await Api().deleteData("request/${requestId}");
    if (res.statusCode == 200) {
      print("request/${requestId}");
      pr.show();
      setState(() {
        _futureRequest=fetchRequest();
      });
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
        pr.hide();
      });
    }
  }

  _deleteEvent(eventId) async {
    var res = await Api().deleteData("event/${eventId}");
    if (res.statusCode == 200) {
      print("event/${eventId}");
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
Future<List<User>> _lifeSaved(user)async{
  var res = await Api().getData('${user["_id"]}/lifeSaved');
  List<User> users=[];

  if(res.statusCode==200)
    {
     print(res.body);
      var bodys = json.decode(res.body);
      print("pariyaaasssssssssssssssssssssssssssssssssssssssssssssssssssssssssaaa ${res.statusCode}");

      for (Map u in bodys) {

        Requestor req = Requestor.fromJson(u);
        users.add(req.user);
      }
    }
    return users;
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

  Future<List<Campaign>> fetchEvent() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("event");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Campaign> events = [];
      for (Map u in body) {
        Campaign event = Campaign.fromJson(u);
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

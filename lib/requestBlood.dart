import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/request/blood_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chat/message_screen.dart';

class RequestBlood extends StatefulWidget {
  @override
  _RequestBloodState createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  TextEditingController location = new TextEditingController();
  TextEditingController bloodGroup = new TextEditingController();
  TextEditingController reason = new TextEditingController();
  TextEditingController locationSearch = new TextEditingController();

  List<String> _bloodGroup = [
    "A",
    "AB",
    "B",
    "O",
  ];
  List<Marker> allMarkers = [];
  String dropdownValue;

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _controller2;
  bool isMapCreated = false;
  var pr;
  Uint8List customIcon;
  Uint8List customHereIcon;
  Set<Marker> markers;
  static double latitude;
  static double longitude;
  var addresses;
  var first;
  static CameraPosition _userLocation;
  var _findDonor;

  getUserAddress() async {
    final coordinates = new Coordinates(latitude, longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      first = addresses.first;
      locationSearch.text = first.addressLine.toString();
    });
    print("${first.featureName} : ${first.addressLine}");
  }

  void addressToLocation() async {
    String query = locationSearch.text;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    setState(() {
      location.text = query;
//      latitude = first.coordinates.latitude;
//      longitude = first.coordinates.longitude;
      _userLocation = CameraPosition(
          bearing: 192.8334901395799,
          target:
              LatLng(first.coordinates.latitude, first.coordinates.longitude),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414);
    });
  }

  void getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _userLocation = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(position.latitude, position.longitude),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414);
    });
  }

  //maps customization
  changeMapMode() {
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller2.setMapStyle(mapStyle);
  }

  CameraPosition _initialLocation = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
  );

//  static final CameraPosition _userLocation = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(latitude, longitude),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

  createMarker(context) async {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      await getBytesFromAsset('assets/images/bloodMarker.png', 100)
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
    if (customHereIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      await getBytesFromAsset('assets/images/imhere.png', 100).then((icon) {
        setState(() {
          customHereIcon = icon;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
//    getUserLocation();
    fetchUser();
    _findDonor = findDonor();
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    Size size = MediaQuery.of(context).size;
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
    if (isMapCreated) {
      changeMapMode();
    }
    return WillPopScope(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height * 1,
                child: GoogleMap(
                  initialCameraPosition: _initialLocation,
                  zoomControlsEnabled: false,
                  markers: Set.from(allMarkers),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    _controller2 = controller;
                    isMapCreated = true;
                    changeMapMode();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.11,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          FontAwesomeIcons.fly,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        onPressed: () {
                          addressToLocation();
                          _goToUserLocation();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Container(
                      width: size.width * 0.7,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, top: 2.0),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: size.width * 0.037,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                              size: 25,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Search Location...",
                            contentPadding:
                                EdgeInsets.only(bottom: 15.0, left: -14.0),
                            hintStyle: TextStyle(fontSize: size.width * 0.035),
                          ),
                          controller: locationSearch,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: size.width * 0.08,
                bottom: 200,
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.11,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.all((Radius.circular(40)))),
                  child: FlatButton(
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    onPressed: () {
                      getUserLocation();
                      getUserAddress();
                      _goToUserLocation();
                    },
                    child: Icon(
                      FontAwesomeIcons.flag,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                  initialChildSize: 0.2,
                  minChildSize: 0.2,
                  maxChildSize: 0.6,
                  builder: (BuildContext c, s) {
                    return SingleChildScrollView(
                      controller: s,
                      child: Container(
                        width: size.width * 1,
                        height: size.height * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffffbcaf),
                                kGradient2.withOpacity(0.7)
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Request Blood",
                                style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontFamily: "Muli"),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Form(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: size.height * 0.07,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        spreadRadius: 3,
                                                        blurRadius: 9)
                                                  ]),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: TextFormField(
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.042,
                                                      color: Colors.black),
                                                  cursorColor: Colors.black,
                                                  decoration: InputDecoration(
                                                      icon: Icon(
                                                        Icons.location_on,
                                                        color: Colors.redAccent,
                                                      ),
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText: first == null
                                                          ? "location"
                                                          : first.addressLine
                                                              .toString(),
                                                      hintStyle: TextStyle(
                                                          fontSize: size.width *
                                                              0.035),
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0)),
                                                  controller: location,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        height: size.height * 0.07,
                                        width: size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Row(
                                            children: <Widget>[
                                              FaIcon(
                                                FontAwesomeIcons.tint,
                                                color: Colors.redAccent,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: DropdownButton<String>(
                                                    underline: SizedBox(),
                                                    focusColor:
                                                        Colors.lightBlue,
                                                    value: dropdownValue,
                                                    icon: Icon(
                                                      Icons.unfold_more,
                                                      color: Colors.black,
                                                    ),
                                                    isExpanded: true,
                                                    hint: Text(
                                                      "Blood group",
                                                      style: TextStyle(
                                                          fontSize: size.width *
                                                              0.035),
                                                    ),
                                                    iconSize: 24,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        dropdownValue =
                                                            newValue;
                                                      });
                                                    },
                                                    items: <String>[
                                                      'A',
                                                      'B',
                                                      'AB',
                                                      'O'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: size.height * 0.17,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        spreadRadius: 3,
                                                        blurRadius: 9)
                                                  ]),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: TextFormField(
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.042,
                                                      color: Colors.black),
                                                  cursorColor: Colors.black,
                                                  decoration: InputDecoration(
                                                    icon: Icon(
                                                      Icons.description,
                                                      color: Colors.redAccent,
                                                    ),
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    hintText: 'Reason',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            size.width * 0.035),
                                                  ),
                                                  controller: reason,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: kPrimaryColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 7,
                                                    spreadRadius: 3,
                                                    color: Colors.black
                                                        .withOpacity(0.25))
                                              ]),
                                          child: FlatButton(
                                            onPressed: () {
                                              pr.show();
                                              addEvent();
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: FaIcon(
                                              FontAwesomeIcons.search,
                                              size: size.width * 0.05,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addEvent() async {
//    if (_formKey.currentState.validate()) {
//    } else {
//      print("Could added. Wrong input ");
//    }
  setState(() {
    _findDonor = findDonor();

  });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var user = jsonDecode(userjson);
    var data = {
      "location": location.text,
      "bloodType": dropdownValue,
      "reason": reason.text,
      "user_id": user["_id"],
      "donor_id": ""
    };

    var res = await Api().postData(data, "request");
    if (res.statusCode == 200) {
      pr.hide();
      eventInfoDialog(context);
    }

  }


  Future<List<User>> fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var currentUser = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("user");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<User> users = [];
      var count = 2;
      for (var u in body) {
        count++;
        User user = User.fromJson(u);
        double lat = user.latitude.toDouble();
        double lon = user.longitude.toDouble();
        allMarkers.add(Marker(
            markerId: MarkerId('myMarker${count}'),
            icon: user.email == currentUser['email']
                ? BitmapDescriptor.fromBytes(customHereIcon)
                : BitmapDescriptor.fromBytes(customIcon),
            draggable: false,
            onTap: () {
              print("I m here");
              print(user.email);
              print(currentUser['email']);
            },
            position: LatLng(lat, lon)));
      }
      return users;
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<void> _goToUserLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_userLocation));
  }

  Future<bool> eventInfoDialog(context) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                "Request has been made. This are the list of suitable donors"),
            content:              Column(
              mainAxisSize: MainAxisSize.min,

              children: [                          SizedBox(height: 20,),

                FutureBuilder(
                    future: _findDonor,
                    builder: (context,snapshot){
                      if(snapshot.data.length==0){
                        return Container(
                          height: 350,
                          width: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Sorry for the time being, no user that compatible with you yet :("),
                              SvgPicture.asset(
                                "assets/images/noData.svg",
                                semanticsLabel: 'A red up arrow',height: 200,
                              ),
                            ],
                          ),
                        );

                      }
                      return Container(
                        height: 300,
                        width: size.width,

                        child: Container(
                          child: ListView.builder(
                              shrinkWrap: true,

                              scrollDirection: Axis.horizontal,

                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context,int index){

                                return Container(
                                  height: 150,
                                  width: 250,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(snapshot.data[index].imageURL))),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: size.height*0.03),
                                          Text("Username: "+snapshot.data[index].username),
                                          Text("Blood Type: " + snapshot.data[index].bloodtype),
                                          Text("Gender: "+snapshot.data[index].gender),
                                          Text("Phone Number: "+snapshot.data[index].phoneNumber),
                                          SizedBox(height: size.height*0.03),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: size.height * 0.05,
                                            width: size.width * 0.2,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                color: kPrimaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 7,
                                                      spreadRadius: 1,
                                                      color: Colors.black
                                                          .withOpacity(0.1))
                                                ]),
                                            child: FlatButton(
                                                onPressed: () {
                                                  print(snapshot.data[index].notificationToken);
                                                  getQue(snapshot.data[index].notificationToken);
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                child:Text("Notify")
                                            ),
                                          ),
                                          Container(
                                            height: size.height * 0.05,
                                            width: size.width * 0.2,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                color: kPrimaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 7,
                                                      spreadRadius: 3,
                                                      color: Colors.black
                                                          .withOpacity(0.25))
                                                ]),
                                            child: FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => MessageScreen(user: snapshot.data[index])),
                                                  );
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                child:Text("Chat")
                                            ),
                                          )
                                        ],
                                      )

                                    ],
                                  )
                                );}
                          ),
                        ),
                      );}
                ),
              ],
            )
              ,
            actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => BloodRequest()));
                      },
                    )
          ]);
        }
    );
  }

  Future getQue(id) async {
    List<String> token=[];
    if(token!=null){
      //call php file
      token.add(id);
      var data={
        "token": id,
      };print(token);
      var res = await Api().postData(data,"requestNotification");
//        return json.decode(res.body);
    }
    else{
      print("Token is null");
    }
  }

  Future<List<User>> findDonor() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("${dropdownValue}/findDonor");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<User> users = [];
      for (var u in body) {
        User user = User.fromJson(u);
        if(userjson["_id"]!=user.id){
          users.add(user);

        }
      }
      return users;
    } else {
      throw Exception('Failed to load album');
    }
  }

}

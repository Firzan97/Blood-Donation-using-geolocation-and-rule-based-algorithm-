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



class RequestBlood extends StatefulWidget {
  @override
  _RequestBloodState createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  TextEditingController location = new TextEditingController();
  TextEditingController bloodGroup = new TextEditingController();
  TextEditingController reason = new TextEditingController();

  List<String> _bloodGroup = [
    "A",
    "AB",
    "B",
    "O",
  ];
  List<Marker> allMarkers = [];
  String dropdownValue ;

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

  getUserAddress()async{
    final coordinates = new Coordinates(latitude, longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      first = addresses.first;

    });
    print("${first.featureName} : ${first.addressLine}");
  }

  void getUserLocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  //maps customization
  changeMapMode(){
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async{
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle){
    _controller2.setMapStyle(mapStyle);
  }

  CameraPosition _initialLocation = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
  );

  static final CameraPosition _userLocation = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(latitude, longitude),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  createMarker(context) async{
    if(customIcon==null){
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      await getBytesFromAsset('assets/images/bloodMarker.png', 100)
          .then((icon) {
        setState(() {
          customIcon =icon;
        });
      });
    }
    if(customHereIcon==null){
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      await getBytesFromAsset('assets/images/imhere.png', 100)
          .then((icon) {
        setState(() {
          customHereIcon =icon;
        });
      });
    }

  }

//  CameraPosition _initialLocation = CameraPosition(
//    target: LatLng(37.43296265331129, -122.08832357078792),
//    zoom: 14.4746,
//  );
//
//  static final CameraPosition _userLocation = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(6.1756691, 102.2070327),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    getUserLocation();
    fetchUser();

  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    Size size = MediaQuery.of(context).size;
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
    if (isMapCreated) {
      changeMapMode();
    }
    return  Scaffold(
            body: Container(
                    child:Stack(
                      children: <Widget>[
                        Container(
                          height: size.height * 1,
                          child: GoogleMap(
                            initialCameraPosition: _initialLocation,
                            zoomControlsEnabled: true,
                            markers: Set.from(allMarkers),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                              _controller2=controller;
                              isMapCreated = true;
                              changeMapMode();
                            },
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: size.height*0.45,
                          child: FlatButton(
                              onPressed: (){
                                getUserAddress();
                                _goToUserLocation();
                              },

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Container(
                              height: size.height*0.05,
                              width: size.width*0.1,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white.withOpacity(0.1),
                                        spreadRadius: 3,
                                        blurRadius: 9
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all((Radius.circular(10)))
                              ),
                              child: Icon(
                                FontAwesomeIcons.searchLocation,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height*0.45,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Container(
                              height: size.height*0.05,
                              width: size.width*0.1,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 9
                                  )
                                ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all((Radius.circular(10)))
                              ),
                              child: Icon(
                                Icons.pin_drop,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        )
                        ,
                          DraggableScrollableSheet(
                              initialChildSize: 0.05,
                              minChildSize: 0.05,
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
                                                fontSize: 22,
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
                                                        padding:
                                                        const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          height: size.height *
                                                              0.07,
                                                          width: size.width,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  32),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.1),
                                                                    spreadRadius: 3,
                                                                    blurRadius: 9)
                                                              ]),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                            child: TextFormField(
                                                              cursorColor: Colors
                                                                  .black,
                                                              decoration: InputDecoration(
                                                                icon: Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Colors
                                                                      .redAccent,
                                                                ),
                                                                border: InputBorder
                                                                    .none,
                                                                focusedBorder:
                                                                InputBorder.none,
                                                                enabledBorder:
                                                                InputBorder.none,
                                                                errorBorder:
                                                                InputBorder.none,
                                                                disabledBorder:
                                                                InputBorder.none,
                                                                hintText: first==null ? "location" :    first.addressLine.toString()
                                                                ,
                                                              ),
                                                              controller: location,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(30))
                                                    ),
                                                    height: size.height * 0.07,
                                                    width: size.width,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          left: 8.0, right: 8.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          FaIcon(
                                                            FontAwesomeIcons.tint,
                                                            color: Colors
                                                                .redAccent,),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                              child: DropdownButton<
                                                                  String>(
                                                                underline: SizedBox(),
                                                                focusColor: Colors
                                                                    .lightBlue,
                                                                value: dropdownValue,
                                                                icon: Icon(Icons
                                                                    .unfold_more,
                                                                  color: Colors
                                                                      .black,),
                                                                isExpanded: true,
                                                                hint: Text(
                                                                  "Blood group",
                                                                  style: TextStyle(
                                                                      fontSize: 15
                                                                  ),),
                                                                iconSize: 24,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.5)),
                                                                onChanged: (
                                                                    String newValue) {
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
                                                                ]
                                                                    .map<
                                                                    DropdownMenuItem<
                                                                        String>>((
                                                                    String value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: value,
                                                                    child: Text(
                                                                        value),
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
                                                  padding: const EdgeInsets.all(
                                                      8.0),
                                                  child: Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          height: size.height *
                                                              0.17,
                                                          width: size.width,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  15),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.1),
                                                                    spreadRadius: 3,
                                                                    blurRadius: 9)
                                                              ]),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(left:
                                                                8.0),
                                                            child: TextFormField(
                                                              cursorColor: Colors
                                                                  .black,
                                                              decoration: InputDecoration(
                                                                icon: Icon(
                                                                  Icons
                                                                      .description,
                                                                  color: Colors
                                                                      .redAccent,
                                                                ),
                                                                border: InputBorder
                                                                    .none,
                                                                focusedBorder:
                                                                InputBorder.none,
                                                                enabledBorder:
                                                                InputBorder.none,
                                                                errorBorder:
                                                                InputBorder.none,
                                                                disabledBorder:
                                                                InputBorder.none,
                                                                hintText: 'Reason',
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
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                          color: kPrimaryColor,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 7,
                                                                spreadRadius: 3,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    0.25))
                                                          ]),
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          pr.show();
                                                          addEvent();
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                        ),
                                                        child: FaIcon(
                                                            FontAwesomeIcons
                                                                .search),
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
                              }
                          ),
                      ],
                    ),
                  ),
                );

  }

  Future<void> addEvent() async {
//    if (_formKey.currentState.validate()) {
//    } else {
//      print("Could added. Wrong input ");
//    }
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var user = jsonDecode(userjson);
    var data = {
      "location": location.text,
      "bloodType": dropdownValue,
      "reason": reason.text,
      "user_id": user["_id"],
    };

    var res = await Api().postData(data, "request");
    print(res.statusCode);
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
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  Future<void> _goToUserLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_userLocation));
  }

  Future<bool> eventInfoDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                "Request has been made. Please wait a minute for the system to find suitable donors"),
            content: Text("Thank you :D"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BloodRequest()));
                },
              )
            ],
          );
        });
  }

}

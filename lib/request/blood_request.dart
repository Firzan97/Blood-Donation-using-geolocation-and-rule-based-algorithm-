import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/model/request.dart';
import 'package:easy_blood/request/findRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodRequest extends StatefulWidget {
  @override
  _BloodRequestState createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _controller2;
  static double latitude;
  static double longitude;
  bool isMapCreated = false;
  var status;
  Uint8List customIcon;
  Uint8List customHereIcon;
  Set<Marker> markers;
  PageController _pageController;
  Future<List<Requestor>> _futureRequest;
  List<User> a = [];
  String view="detail";

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

  List<Marker> allMarkers= [];

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

  void initState(){
    super.initState();
    getUserLocation();
    fetchUser();
    _futureRequest = fetchRequest();


//    allMarkers.add(Marker(
//      markerId: MarkerId('myMarker'),
//      draggable: false,
//      onTap: (){
//        print("I m here");
//      },
//        position: LatLng(6.1756679, 102.2070323)
//    ));
  }

  final pi = 3.1415926535897932;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    createMarker(context);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Muli"
      ),
      home: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              latitude==null ? LoadingScreen()
                  : Positioned(
                child: Container(
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
              ),
              Positioned(
                top: 50,
                left: size.width * 0.3,
                child: Container(
                  height: size.height * 0.055,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 12)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: _goToUserLocation,
                    child: Text("Locate your location",style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                ),
              ),
              Positioned(
                bottom: 250,
                child: Padding(
                  padding: const EdgeInsets.only(left: 163),
                  child: Container(
                    height: size.height*0.05,
                    width: size.width*0.20,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(

                      children: <Widget>[
                        IconButton(icon: FaIcon(FontAwesomeIcons.handsHelping,color: Colors.black,),
                        ),
                        Text("AB+",style: TextStyle(fontWeight: FontWeight.w700),)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 55,
                left: 15,
                child: Container(
                  height: size.height*0.26,
                  width: size.width*0.92,
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.circular(7)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(Icons.details),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Nearest Request is 10.0  KM",style: TextStyle(
                          fontFamily: "Muli",
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.w700
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("FIRZAN AZRAI",style: TextStyle(
                            fontFamily: "Muli",
                          fontWeight: FontWeight.w700
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Lot 702, Kampung Kok Keli",style: TextStyle(
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w500
                        ),),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: size.height*0.06,
                              width: size.width*0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kPrimaryColor,
                              ),
                              child: FlatButton(
                                onPressed: (){
                                  fetchUser();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(child: Text("NAVIGATE",style: TextStyle(
                                  fontWeight: FontWeight.bold,fontFamily: "Muli",color: Colors.white,fontSize: 15
                                ),)),
                              ),
                            ),
                            Container(
                              height: size.height*0.06,
                              width: size.width*0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kPrimaryColor,
                              ),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(child: Text("CALL",style: TextStyle(
                                    fontWeight: FontWeight.bold,fontFamily: "Muli",color: Colors.white,fontSize: 15
                                ),)),
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
              DraggableScrollableSheet(
                  initialChildSize: 0.05,
                  minChildSize: 0.05,
                  maxChildSize: 0.95,
                  builder: (BuildContext c, s)
                  {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xffffbcaf),
                              kGradient2.withOpacity(0.4)
                            ]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: SingleChildScrollView(
                            controller: s,
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.drag_handle),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        child: Container(
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2),
                                              color: view=="list" ? kPrimaryColor : Colors.white
                                          ),
                                          child: Center(
                                            child: Text("List",style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Muli",
                                                color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            view="list";
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 30,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.black
                                        ),
                                        child: Center(
                                          child: Text("Blood Request List",style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                                fontFamily: "Muli",
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        child: Container(
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2),
                                              color: view=="detail" ? kPrimaryColor : Colors.white
                                          ),
                                          child: Center(
                                            child: Text("Detail",style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Muli",
                                                color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            view="detail";
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                FutureBuilder(
                                    future: _futureRequest,
                                    builder: (context, snapshot) {
                                      if(snapshot.data==null){
                                        return LoadingScreen();
                                      }
                                      else{
                                      return Container(
                                        height: 600,
                                        child: ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if(snapshot.data==null){
                                                return LoadingScreen();
                                              }
                                              return view=="list" ? Stack(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(10.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10)),
                                                      child: ListTile(
                                                        leading: Container(
                                                          height:
                                                              size.height * 0.149,
                                                          width: size.width * 0.11,
                                                          decoration: BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                    a[index].imageURL),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(5)),
                                                        ),
                                                        title:
                                                            Text(a[index].username),
                                                        subtitle:
                                                            Text("${snapshot.data[index].bloodType}",style: TextStyle(
                                                              color: Colors.red
                                                            ),),
                                                        trailing: Container(
                                                          width: 130,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              IconButton(
                                                                icon: Icon(
                                                                  Icons.call,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                                onPressed: () {
                                                                  launch(('tel://${a[index].phoneNumber}'));       //launch(('tel://99999xxxxx'));


                                                                },
                                                              ),
                                                              IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .message,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                                onPressed: () {

                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
//                                                  Positioned(
//                                                    bottom: 0,
//                                                    left:160,
//                                                    child: GestureDetector(
//                                                      child: Container(
//                                                        height: 30,
//                                                        width: 80,
//                                                        decoration: BoxDecoration(
//                                                            borderRadius: BorderRadius.circular(20),
//                                                            color: Colors.black
//                                                        ),
//                                                        child: Center(
//                                                          child: Text("Details",style: TextStyle(
//                                                              fontWeight: FontWeight.w700,
//                                                              fontFamily: "Muli",
//                                                              color: Colors.white),
//                                                          ),
//                                                        ),
//                                                      ),
//                                                      onTap: (){
//                                                        Navigator.push(
//                                                          context,
//                                                          MaterialPageRoute(
//                                                              builder:
//                                                                  (context) =>
//                                                                  FindRequest()),
//                                                        );
//                                                      },
//                                                    ),
//                                                  ),
                                                ],
                                              ) : Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(top: 10.0, left: 11, right: 11),
                                                      child: Container(
                                                        width: size.width * 1,
                                                        decoration:
                                                        BoxDecoration(color: Colors.white, boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.black.withOpacity(0.05),
                                                              blurRadius: 10,
                                                              spreadRadius: 3)
                                                        ]),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: kPrimaryColor.withOpacity(0.8)
                                                              ),
                                                              child: ListTile(
                                                                leading: Container(
                                                                  height: size.height * 0.149,
                                                                  width: size.width * 0.15,
                                                                  decoration: BoxDecoration(

                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors.grey.withOpacity(0.1),
                                                                            blurRadius: 8,
                                                                            spreadRadius: 5)
                                                                      ],
                                                                      shape: BoxShape.circle,
                                                                      image: DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image:
                                                                        NetworkImage(a[index].imageURL),
                                                                      )),
                                                                ),
                                                                title: Text(a[index].username),
                                                                isThreeLine: true,
                                                                subtitle: RichText(
                                                                  text: TextSpan(
                                                                    text: 'Looking for ${snapshot.data[index].bloodType} blood donor\n',
                                                                    style: TextStyle(
                                                                        color: Colors.black
                                                                    ),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: 'Posted 3 hours ago',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w300,
                                                                              fontSize: 10.0)),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(
                                                                  left: 20.0, top: 10, bottom: 15),
                                                              child: Text(
                                                                  snapshot.data[index].reason),
                                                            ),
                                                            Container(
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Image.asset("assets/images/lari2.jpg"),
                                                                  Container(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Stack(children: <Widget>[
                                                                          Image.asset(
                                                                            "assets/images/begdarah.png",width: 50,),
                                                                          Positioned(
                                                                              top: size.height * 0.028,
                                                                              left: size.width * 0.04,
                                                                              child: Transform.rotate(angle: - pi / 5,
                                                                                child: Text("AB",
                                                                                    style: TextStyle(
                                                                                        fontSize: 9,
                                                                                        color: Colors.white,
                                                                                        fontWeight:
                                                                                        FontWeight.w700)),
                                                                              ))
                                                                        ]),
                                                                        Text(snapshot.data[index].location),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0, left: 15),
                                                                          child: FlatButton(
                                                                            color: kThirdColor,
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius:
                                                                              BorderRadius.circular(5),
                                                                            ),
                                                                            child: Text("Saves a life",style: TextStyle(color: Colors.white70),),
                                                                            onPressed: () {},
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                               color: Colors.grey.withOpacity(0.1)
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: FlatButton(
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          Icon(Icons.share),
                                                                          Text("Share")
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      );}
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
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
        print("dapattt");
        Requestor req = Requestor.fromJson(u);
        User user = req.user;
        a.add(user);
        requests.add(req);
        print("bsabsabsbasbabsabsasqa");
      }

      return requests;
    } else {
      throw Exception('Failed to load album');
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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
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
}

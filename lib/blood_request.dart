import 'dart:async';
import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/findRequest.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  BitmapDescriptor customIcon;
  Set<Marker> markers;
  PageController _pageController;

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

  createMarker(context){
    if(customIcon==null){
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, "assets/images/bloodMarker.png")
      .then((icon) {
        setState(() {
          customIcon =icon;
        });
      });
    }
  }

  void initState(){
    super.initState();
    getUserLocation();
    fetchUser();

//    allMarkers.add(Marker(
//      markerId: MarkerId('myMarker'),
//      draggable: false,
//      onTap: (){
//        print("I m here");
//      },
//        position: LatLng(6.1756679, 102.2070323)
//    ));
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    createMarker(context);
    return MaterialApp(
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
                                        color: Colors.white
                                      ),),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height*0.01,),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                              color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                            ),
                                      child: ListTile(
                                        leading: Container(
                                          height: size.height * 0.149,
                                          width: size.width * 0.15,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/lari2.jpg"),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      title: Text("SYAZWAN ASRAF"),
                                      subtitle: Text("Blood Group O"),
                                      trailing: Container(
                                        width: 130,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.call,
                                                color: kPrimaryColor,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FindRequest()),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.call_missed_outgoing,
                                                color: kPrimaryColor,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FindRequest()),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: ListTile(
                                      leading: Container(
                                        height: size.height * 0.149,
                                        width: size.width * 0.15,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/lari2.jpg"),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                      ),
                                      title: Text("SYAZWAN ASRAF"),
                                      subtitle: Text("Blood Group O"),
                                      trailing: Container(
                                        width: 130,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.call,
                                                color: kPrimaryColor,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FindRequest()),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.call_missed_outgoing,
                                                color: kPrimaryColor,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FindRequest()),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: ListTile(
                                      leading: Container(
                                        height: size.height * 0.149,
                                        width: size.width * 0.15,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/lari2.jpg"),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                      ),
                                      title: Text("SYAZWAN ASRAF"),
                                      subtitle: Text("Blood Group O"),
                                      trailing: Container(
                                        width: 130,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.call,
                                                color: kPrimaryColor,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FindRequest()),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.call_missed_outgoing,
                                                color: kPrimaryColor,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FindRequest()),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<User>> fetchUser() async {

    var res = await Api().getData("user");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<User> users = [];
      var count = 2;
      for (var u in body) {
        count++;
        print(count);
        User user = User.fromJson(u);
        print(user.longitude);
        double lat = user.latitude.toDouble();
        double lon = user.longitude.toDouble();
        print(lat);
        print(lon);
        allMarkers.add(Marker(
            markerId: MarkerId('myMarker${count}'),
           icon: customIcon,
            draggable: false,
            onTap: () {
              print("I m here");
            },
            position: LatLng(lat,lon)));

      }
      return users;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> _goToUserLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_userLocation));


  }
}

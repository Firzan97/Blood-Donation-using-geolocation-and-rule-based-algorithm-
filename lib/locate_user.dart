import 'dart:async';

import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class LocateUser extends StatefulWidget {

  @override
  _LocateUserState createState() => _LocateUserState();
}

class _LocateUserState extends State<LocateUser> {
  Completer<GoogleMapController> _controller = Completer();
  static double latitude;
  static double longitude;
  bool isMapCreated = false;
  List<Marker> myMarker = [];

  void getUserLocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  changeMapMode(){
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async{
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle){
    _controller;
  }

  _handleTap(LatLng tappedPoint){
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        )
      );
    });
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

  void initState(){
    super.initState();
    getUserLocation();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (isMapCreated) {
      changeMapMode();
    }
    return MaterialApp(
        home: Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                child: GoogleMap(
                    initialCameraPosition: _initialLocation,
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      isMapCreated = true;
                      changeMapMode();
                    },
                  markers: Set.from(myMarker),
                onTap: _handleTap,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
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
                  child: Text("Locate your location"),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _goToUserLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_userLocation));
  }
}

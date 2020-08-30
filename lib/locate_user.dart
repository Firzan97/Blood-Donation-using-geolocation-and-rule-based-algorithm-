import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateUser extends StatefulWidget {

  @override
  _LocateUserState createState() => _LocateUserState();
}

class _LocateUserState extends State<LocateUser> {
  GoogleMapController _controller;

  bool isMapCreated = false;

  changeMapMode(){
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async{
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle){
    _controller.setMapStyle(mapStyle);
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
                    initialCameraPosition: CameraPosition(
                      target: LatLng(40, -74),
                      zoom: 14.4746,
                    ),
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                      isMapCreated = true;
                      changeMapMode();
                      setState(() {});
                    }),
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
                  onPressed: () {},
                  child: Text("Locate your location"),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

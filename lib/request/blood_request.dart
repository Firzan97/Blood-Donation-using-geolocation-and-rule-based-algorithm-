import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/chat/message_screen.dart';
import 'package:easy_blood/model/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
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
  var userDetail,requestDetail;
  List<User> requestedUserList = [];
  var distance;
  List<double> distancesList=[];
  var nearestRequestor;
  var nearestUserRequestor;
  var temp=1000.0;
  var currentUser;

  double _originLatitude = 6.1756691, _originLongitude = 102.2070327;
  double _destLatitude = 3.1390, _destLongitude = 101.6869;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = DotEnv().env['GOOGLE_API_KEY'];

_getUserData()async{
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  currentUser = jsonDecode(localStorage.getString("user"));
}
  Future getDistance(originLat,OriginLon,destinationLat,destinationLon)async{
  var distanceInMeters = await Geolocator().distanceBetween(originLat,OriginLon,destinationLat,destinationLon);
  setState(() {
    distance=distanceInMeters/1000;
  });
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
    target: LatLng(2.9105, 101.1068),
    zoom: 5.4746,
  );

  static final CameraPosition _userLocation = CameraPosition(
      target: LatLng(latitude, longitude),
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
      await getBytesFromAsset('assets/images/here1.png', 100)
          .then((icon) {
        setState(() {
          customHereIcon =icon;
        });
      });
    }

  }

  @override
  void initState(){
    super.initState();
    _getUserData();
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
                    zoomControlsEnabled: false,
                    polylines: Set<Polyline>.of(polylines.values),
                    markers: Set.from(allMarkers),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _controller2=controller;
                      isMapCreated = true;
                      changeMapMode();
                      polylines: Set<Polyline>.of(polylines.values);

                    },
                  ),
                ),
              ),
              Positioned(
                top: size.height*0.05,
                left: size.width * 0.3,
                right: size.width*0.3,
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
                      color: Colors.white,
                        fontSize: size.width*0.031
                    ),),
                  ),
                ),
              ),
              requestDetail!= null ? Positioned(
                bottom: size.height*0.35,
                child: Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.height*0.04,
                          width: size.width*0.14,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 9,
                                spreadRadius: 3
                              )
                            ],
                              color: Colors.yellowAccent,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: requestDetail!= null ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.tint,color: Colors.red,size: size.width*0.05,),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(requestDetail.bloodType,style: TextStyle(fontWeight: FontWeight.w500,                                              fontSize: size.width*0.031
                                ),),
                              )
                            ],
                          ) : LoadingScreen()
                        ),
                      ),
                    ],
                  ),
                ),
              ) : SizedBox(),
              Positioned(
                bottom: size.height*0.08,
                left: 15,
                child: Container(
                  height: size.height*0.25,
                  width: size.width*0.92,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(7)
                  ),
                  child: userDetail!= null ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(Icons.details),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(distance==null ? "The nearest request: ${temp}KM" : "Distance: ${distance.toString()}KM",style: TextStyle(
                          fontFamily: "Muli",
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.w700,
                            fontSize: size.width*0.031

                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(userDetail.username,style: TextStyle(
                            fontFamily: "Muli",
                          fontWeight: FontWeight.w700,
                            fontSize: size.width*0.043

                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(requestDetail.location,style: TextStyle(
                            fontFamily: "Muli",
                            fontSize: size.width*0.031,
                            fontWeight: FontWeight.w500,
                        ),),
                      ),
                      SizedBox(height: size.height*0.01,),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: size.height*0.06,
                              width: size.width*0.28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kPrimaryColor,
                              ),
                              child: FlatButton(
                                onPressed: (){
                                  _navigateToRequestorLocation(requestDetail.location);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(child: Text("NAVIGATE",style: TextStyle(
                                  fontWeight: FontWeight.bold,fontFamily: "Muli",color: Colors.white,fontSize: size.width*0.032

                                ),)),
                              ),
                            ),
                            Container(
                              height: size.height*0.06,
                              width: size.width*0.28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kPrimaryColor,
                              ),
                              child: FlatButton(
                                onPressed: (){
                                    launch(('tel://${userDetail.phoneNumber}'));       //launch(('tel://99999xxxxx'));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(child: Text("CALL",style: TextStyle(
                                    fontWeight: FontWeight.bold,fontFamily: "Muli",color: Colors.white,fontSize: size.width*0.032
                                ),)),
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ) : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Sorry there are no request yet!"),
                        SizedBox(height: size.height*0.03,),
                        Image.asset("assets/images/norequest.png",scale: 4,),
                      ],
                    ),
                  )
                ),
              ),
              userDetail!= null ? DraggableScrollableSheet(
                  initialChildSize: 0.05,
                  minChildSize: 0.05,
                  maxChildSize: 0.95,
                  builder: (BuildContext c, s)
                  {
                    return Container(                                width: size.width * 1,

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
                      child: SingleChildScrollView(
                        controller: s,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: [
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
                                                color: Colors.black,

                                              ),
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
                                ],
                              ),
                            ),

                            FutureBuilder(
                                future: _futureRequest,
                                builder: (context, snapshot) {
                                  if(snapshot.data==null){
                                    return LoadingScreen();
                                  }
                                  else{
                                  return Container(
                                    height: 500,
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
                                                        Text(a[index].username, style: TextStyle(
                                                          fontSize: size.width*0.038,

                                                        ),),
                                                    subtitle:
                                                        Text("${snapshot.data[index].bloodType}",style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: size.width*0.033,

                                                        ),),
                                                    trailing: Container(
                                                      width: 130,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          a[index].id!=currentUser['_id'] ?
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .message,
                                                              color:
                                                              kPrimaryColor,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => MessageScreen(user: a[index])),
                                                              );
                                                            },
                                                          ) : Container(),
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
                                                            title: Text(a[index].username,style: TextStyle(
                                                              fontSize: size.width*0.042,

                                                            ),),
                                                            isThreeLine: true,
                                                            subtitle: RichText(
                                                              text: TextSpan(
                                                                text: 'Looking for ${snapshot.data[index].bloodType} blood donor\n',
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                  fontSize: size.width*0.035,

                                                                ),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                      text: 'Posted 3 hours ago',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w300,
                                                                        fontSize: size.width*0.033,
                                                                      )),
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
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            bottom:4.0,top: 2.0, left: 15),
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
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                           color: Colors.grey.withOpacity(0.5)
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
                    );
                  }) : SizedBox()
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
        Requestor req = Requestor.fromJson(u);
        User user = req.user;
        a.add(user);
        requests.add(req);
      }
      setState(() {
        userDetail=a[0];
        requestDetail=requests[0];
      });
      return requests;
    } else {
      throw Exception('Failed to load album');
    }
  }

  _fetchLocation(address)async{
    final query = address;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print(first.coordinates.latitude);
    return first.coordinates;
  }


  Future<User> fetchUserDetail(id) async {
    var res = await Api().getData("user");
    var body = json.decode(res.body);
    User user;
    if (res.statusCode == 200) {
      var count = 0;
      for (var u in body) {
        user = User.fromJson(u);
        if(id==user.id){
          return user;
        }
      }

    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Requestor>> fetchUser() async {

    var res = await Api().getData("request");
    var body = json.decode(res.body);
    var requestList =[];
    if (res.statusCode == 200) {
      List<Requestor> requestors = [];
      var count = 0;
      var nearestCount=0;
      for (var u in body) {

        Requestor requestor = Requestor.fromJson(u);
        User requestedUser = requestor.user;
        requestedUserList.add(requestedUser);
        requestList.add(requestor);

        var addresses = await Geocoder.local.findAddressesFromQuery(requestor.location);
        var first = addresses.first;
        var distanceInMeters = await Geolocator().distanceBetween(double.parse(currentUser['latitude']),double.parse(currentUser['longitude']),first.coordinates.latitude, first.coordinates.longitude);
        distancesList.add(distanceInMeters/1000);
        print("current latitude " + currentUser['latitude'] +"destination latitude " +first.coordinates.latitude.toString());
        if(temp>distancesList.reduce(min)){

          setState(() {
            temp=distancesList.reduce(min);
            nearestCount=count;
          });
        }

        allMarkers.add(Marker(
            markerId: MarkerId('myMarker${count}'),
            icon: requestor.user_id == currentUser['_id']
                ? BitmapDescriptor.fromBytes(customHereIcon)
                : BitmapDescriptor.fromBytes(customIcon),
            draggable: false,
            onTap: () {
              setState(() {
                userDetail =requestor.user;
                requestDetail = requestor;
                getDistance(double.parse(currentUser['latitude']),double.parse(currentUser['longitude']),first.coordinates.latitude, first.coordinates.longitude);
              });
            },
            position: LatLng(first.coordinates.latitude, first.coordinates.longitude)));
        count++;

      }

      setState(() {
        userDetail  = requestedUserList[nearestCount];
        requestDetail= requestList[nearestCount];
      });
      return requestors;
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


  Future<void> _navigateToRequestorLocation(location)async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var currentUser = jsonDecode(localStorage.getString("user"));
    final query = location;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");
    _getPolyline(double.parse(currentUser['latitude']),double.parse(currentUser['longitude']),first.coordinates.latitude, first.coordinates.longitude);
    final CameraPosition _requestLocation = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(first.coordinates.latitude, first.coordinates.longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
   final GoogleMapController controller = await _controller.future;
   controller.animateCamera(CameraUpdate.newCameraPosition(_requestLocation));
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      width: 1,
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline(a,b,c,d) async {
    polylineCoordinates.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(a, b),
        PointLatLng(c, d),
        travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

}

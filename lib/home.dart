import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_blood/about.dart';
import 'package:easy_blood/animation/faceAnimation.dart';
import 'package:easy_blood/bloodEvent.dart';
import 'package:easy_blood/bloodRequest.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/notification.dart';
import 'package:easy_blood/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          theme: ThemeData(primaryColor: kPrimaryColor),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            drawer: Drawer(
              child: Container(
                color: kThirdColor,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: kThirdColor
                        ),
                        accountName: Text("FIRZAN AZRAI"),
                        accountEmail: Text("FirzanAzrai97@gmail.com"),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/images/tonystark.jpg")
                        ),
                      ),
                    ),
            FadeAnimation(1.4,GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      },
                      child: ListTile(
                        title: Text("Profile", style: TextStyle(color: kPrimaryColor),),
                        trailing: Icon(Icons.person),
                      ),
                    )),
                    FadeAnimation(1.4,GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      },
                      child: ListTile(
                        title: Text("Request Blood", style: TextStyle(color: kPrimaryColor)),
                        trailing: Icon(Icons.person),
                      ),
                    )),
                    FadeAnimation(1.4,GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => About()),
                        );
                      },
                      child: ListTile(
                        title: Text("Find Request", style: TextStyle(color: kPrimaryColor)),
                        trailing: Icon(Icons.account_box),
                      ),
                    )),
            FadeAnimation(1.4,GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BloodEvent()),
                        );
                      },
                      child: ListTile(
                        title: Text("Blood Event", style: TextStyle(color: kPrimaryColor)),
                        trailing: Icon(Icons.event),
                      ),
                    )),
            FadeAnimation(1.4,GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BloodRequest()),
                        );
                      },
                      child: ListTile(
                        title: Text("Notification", style: TextStyle(color: kPrimaryColor)),
                        trailing: Icon(Icons.find_in_page),
                      ),
                    )),
                    FadeAnimation(1.4,GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Notifications()),
                        );
                      },
                      child: ListTile(
                        title: Text("About",
                            style: TextStyle(color: kPrimaryColor)),
                        trailing: Icon(Icons.notifications),
                      ),
                    )),
                    FadeAnimation(
                        1.4,
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notifications()),
                            );
                          },
                          child: ListTile(
                            title: Text("Log Out",
                                style: TextStyle(color: kPrimaryColor)),
                            trailing: Icon(Icons.notifications),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 50.0,
              items: <Widget>[
                Icon(Icons.add, size: 30),
                Icon(Icons.list, size: 30),
                Icon(Icons.compare_arrows, size: 30),
                Icon(Icons.call_split, size: 30),
                Icon(Icons.perm_identity, size: 30),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 400),
              onTap: (index) {
                setState(() {
                  _page = index;
                });
              },
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: size.height * 0.35,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 30.0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      text: 'Hai, ',
                                      style: TextStyle(fontWeight: FontWeight.w100,fontSize: 18.0),
                                      children: <TextSpan>[
                                        TextSpan(text: 'Firzan Azrai', style: TextStyle(fontWeight: FontWeight.bold,color: kThirdColor)),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Let's save people's life !",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1,
                                        wordSpacing: 2),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: size.height * 0.07,
                                width: size.width * 0.7,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(11.00)),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text("Locate your location")
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.lightBlue,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.library_books),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    Text("Blood Type."),
                                    Text(
                                      "AB",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.1,
                                    ),
                                    Text("Age."),
                                    Text(
                                      "19",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.1,
                                    ),
                                    Text("Weight."),
                                    Text(
                                      "55KG",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      height: 40.0,
                                      width: 40.0,
                                      child: Icon(Icons.search),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      height: 40.0,
                                      width: 40.0,
                                      child: Icon(Icons.search),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      height: 40.0,
                                      width: 40.0,
                                      child: Icon(Icons.event),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.01),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("New Blood Campaign"),
                                Text("See All")
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 190,
                                height: 170,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 0,
                                      left: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 130,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: kThirdColor,
                                          ),

                                          child: Column(
                                          children: <Widget>[
                                            SizedBox(height: 110.0,),
                                            Text("17/8/2020",style: TextStyle(
                                              color: Colors.white
                                            ),)
                                          ],
                                        ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 4,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5)
                                            ]),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.asset(
                                              "assets/images/dermadarah1.jpg",
                                              width: 100,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 200,
                                height: 170,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 0,
                                      left: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 130,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: kThirdColor,
                                          ),

                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(height: 110.0,),
                                              Text("17/8/2020",style: TextStyle(
                                                  color: Colors.white
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 4,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5)
                                            ]),
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(20.0),
                                            child: Image.asset(
                                              "assets/images/dermadarah1.jpg",
                                              width: 100,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  getPosition();
                                },
                                child: Text("sasas"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

void getPosition() async {
  Position position = await Geolocator()
      .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  print(position.accuracy);
  print(position.longitude);
  print("nate");
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                height: size.height*0.4,
                child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Hai, Firzan Azrai",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  Text(
                                    "Let's save people's life !",
                                    style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1,
                                    wordSpacing: 2),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: size.height*0.02),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: size.height*0.07,
                                width: size.width*0.7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(11.00)
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.location_on,color: Colors.black87,),
                                    Text("Locate your location")
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.lightBlue,
                                  child: Icon(Icons.search,color: Colors.white,),
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
                                    SizedBox(width: size.width*0.03,),
                                    Text("Blood Type."),
                                    Text("AB",style: TextStyle(
                                      color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    ),),
                                    SizedBox(width: size.width*0.1,),
                                    Text("Age."),
                                    Text("19",style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    ),),
                                    SizedBox(width: size.width*0.1,),
                                    Text("Weight."),
                                    Text("55KG",style: TextStyle(
                                        color: Colors.white,
                                      fontWeight: FontWeight.w700
                                    ),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Container(
                    child: Column(
                  children: <Widget>[
                    Row()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    )
    );
  }
}

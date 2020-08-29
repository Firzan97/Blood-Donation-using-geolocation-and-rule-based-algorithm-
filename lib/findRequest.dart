import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class FindRequest extends StatefulWidget {
  @override
  _FindRequestState createState() => _FindRequestState();
}

class _FindRequestState extends State<FindRequest> {
  final pi = 3.1415926535897932;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: size.width * 1,
                height: size.height * 1,
                color: Colors.grey.withOpacity(0.1),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 70.0, left: 11, right: 11),
                      child: Container(
                        width: size.width * 1,
                        decoration:
                            BoxDecoration(color: Colors.white70, boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
//                              Color(0xffff5959),
                                      kGradient1,
                                      kGradient2,
                                    ]),
                        ),
                              child: ListTile(
                                leading: Container(
                                  height: size.height * 0.149,
                                  width: size.width * 0.15,
                                  decoration: BoxDecoration(

                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 8,
                                            spreadRadius: 5)
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                        AssetImage("assets/images/lari2.jpg"),
                                      )),
                                ),
                                title: Text("Firzan Azrai"),
                                isThreeLine: true,
                                subtitle: RichText(
                                  text: TextSpan(
                                    text: 'Looking for AB blood donor\n',
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
                                  "Perlukan darah AB sebanyak 3 beg untuk pembedehan istyeri malam ini. harap dapat disharekan kepada semua pihak"),
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
                                        Text(" Hospital Tumpat Kelantan"),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 55),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Like"),
                                  Text("Comment")
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
//                              Color(0xffff5959),
                                      kGradient1,
                                      kGradient2,
                                    ]),
                              ),
                              child: Row(
                                children: <Widget>[
                                 Container(
                                   child: IconButton(
                                     icon: Icon(Icons.thumb_up),
                                     onPressed: (){

                                     },
                                   ),
                                 ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        FlatButton(
                                          child: Icon(Icons.comment),
                                        ),
                                        Text("Comment")
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        FlatButton(
                                          child: Icon(Icons.share),
                                        ),
                                        Text("Share")
                                      ],
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
              ),
            ),
          ),
        ));
  }
}

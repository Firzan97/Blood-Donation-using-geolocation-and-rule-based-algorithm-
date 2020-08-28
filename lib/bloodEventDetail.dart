import 'package:easy_blood/constant.dart';
import 'package:easy_blood/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BloodEventDetail extends StatelessWidget {
  final Event event;

  const BloodEventDetail({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        home: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                Container(height: size.height),
                Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(

                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/lari2.jpg"),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: size.height * 0.65,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: kGradient1,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  event.name,
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w700),
                                ),
                                Icon(
                                  Icons.location_on,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: size.height*0.5871,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),

                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          dense: true,
                                          leading: Container(
                                              height: 40,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: kGradient1,
                                              ),
                                              child: Icon(Icons.event,
                                                  size: 25, color: kPrimaryColor)),
                                          title: Text(event.location),
                                          subtitle: Text("10:00 AM - 9:00 PM"),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Container(
                                              height: 40,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: kGradient1,
                                              ),
                                              child: Icon(Icons.location_searching,
                                                  size: 25, color: kPrimaryColor)),
                                          title: Text(event.location),
                                          subtitle: Text("ManHattan, Cyberjaya"),
                                        ),
                                        ListTile(
                                          dense: true,
                                          leading: Container(
                                              height: 40,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: kGradient1,
                                              ),
                                              child: Icon(
                                                Icons.create,
                                                size: 25,
                                                color: kPrimaryColor,
                                              )),
                                          title: Text("Hospital kpo"),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 12,
                                              spreadRadius: 3)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "About",
                                            style:
                                                TextStyle(fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "Sebuah kempen dermah darah yang akan diadakan di perak"
                                            "hasil kerjasam hospital kedah dan organisai2 lain. Semua dialu- alukan",
                                            style: TextStyle(wordSpacing: 1),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: FlatButton(
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Text(
                                        "Gonna Join",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

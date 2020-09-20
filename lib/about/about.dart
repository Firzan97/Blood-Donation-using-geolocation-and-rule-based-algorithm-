import 'package:easy_blood/component/curvedBackground.dart';
import 'package:easy_blood/component/custom_dialog.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/constant.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Stack(children: <Widget>[
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          height: size.height * 0.41,
                          width: size.width * 1,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    left: 0,
                                    top: 10,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                      left: 191, top: 25, child: Text("ABOUT")),
                                  Positioned(
                                      top: 60,
                                      left: 100,
                                      child: Image.asset(
                                        "assets/images/bloodcell.png",
                                        width: 200,
                                      )),
                                ]),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[],
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Color(0xffffbcaf), kGradient2]),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 1,
                        width: size.width * 1,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: size.height * 0.3),
                            Container(
                              width: size.width * 0.7,
                              height: size.height * 0.28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              color: Colors.black
                                                  .withOpacity(0.05))
                                        ]),
                                    height: 40,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                      ),
                                        color: Colors.white,
                                        onPressed: () {
                                          whoAreWeDialog(context);
                                        },
                                        child:
                                            Center(child: Text("Who are eligible to donate?"))),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,

                                    ),
                                    height: 40,
                                    child: FlatButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          whyDonateBloodDialog(context);
                                        },
                                        child: Center(
                                            child: Text("Why donate blood?"))),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                    ),
                                    height: 40,
                                    child: FlatButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          developerDialog(context);
                                        },
                                        child:
                                            Center(child: Text("Developer"))),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),

                                    ),
                                    height: 40,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),

                                      ),
                                        color: Colors.white,
                                        onPressed: () {
                                          versionDialog(context);
                                        },
                                        child: Center(child: Text("Version"))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ]),
                  ),
                ],
              ),
            ),
          ),
        ));

  }

  Future<bool> versionDialog(context){
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Version 1.0",
        description:
        "The initial version of the Easy Blood application currently releasing it first version to help more people.",
        buttonText: "Okay",
          image: "assets/images/blood.png"
      ),
    );
  }

  Future<bool> whyDonateBloodDialog(context){
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Why donate blood?",
        description:
        "Blood is the most precious gift that anyone can give to another person — the gift of life. A decision to donate your blood can save a life, or even several if your blood is separated into its components — red cells, platelets and plasma — which can be used individually for patients with specific conditions.",
        buttonText: "Okay",
          image: "assets/images/whydonateblood.gif"
      ),
    );
  }

  Future<bool> developerDialog(context){
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Developer",
        description:
        "Muhammad Firzan Azrai bin Nuzilan \n \n A final year student who created the Easy Blood Application by using Flutter, Laravel, AWS S3, MongoDB as the tech stack",
        buttonText: "Okay",
        image: "assets/images/lari2.jpg"
      ),
    );
  }

  Future<bool> whoAreWeDialog(context){
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Eligible",
        description:
        "To donate blood or platelets, you must be in good general health, weigh at least 110 pounds, and be at least 16 years old. Parental consent is required for blood donation by 16 year olds; 16 year olds are NOT eligible to donate platelets.",
        buttonText: "Okay",
          image: "assets/images/eligible.png"
      ),
    );
  }

}

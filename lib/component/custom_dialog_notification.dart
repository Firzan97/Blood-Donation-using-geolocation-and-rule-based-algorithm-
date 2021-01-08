import 'package:easy_blood/event/bloodEvent.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/constant/constant.dart';
import 'package:intl/intl.dart';

class CustomDialogNotification extends StatelessWidget {
  final String title, description, buttonText,topic;
  final String image;
  final Widget page;

  CustomDialogNotification({
    @required this.title,
    @required this.topic,
    @required this.description,
    @required this.buttonText,
    this.image,
    this.page
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 600,
      child: Stack(
        children: <Widget>[
//          Container(height: 550,
//            width: 600,
//            decoration: new BoxDecoration(
//              color: Colors.white.withOpacity(0.7),
//              shape: BoxShape.rectangle,
//              borderRadius: BorderRadius.circular(padding),
//              boxShadow: [
//                BoxShadow(
//                  color: Colors.black26,
//                  blurRadius: 10.0,
//                  offset: const Offset(0.0, 10.0),
//                ),
//              ],
//            ),),
          Container(
            height: 500,
            width: 600,
            padding: EdgeInsets.only(
              top: avatarRadius ,
              bottom: padding,
              left: padding,
              right: padding,
            ),
            margin: EdgeInsets.only(top: avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width*0.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24.0),
//              Align(
//                alignment: Alignment.bottomRight,
//                child: FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop(); // To close the dialog
//                  },
//                  child: Text(buttonText),
//                ),
//              ),
              ],
            ),
          ),
          Positioned(
            left: size.width*0.10,
            top: 369,
            child: Container(
              height: size.height*0.3,
              width: size.width*0.6,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white24,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(image)
                  )
              ),

            ),
          ),
          Positioned(
            top: 75,
            left: 10,
            child: GestureDetector(
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pop(); // To close the dialog
              },
            ),
          ),
          Positioned(
            top: size.width*0.75,
            left: size.width*0.19,
            child: Container(
              height: 30,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius
                      .circular(20),
                  color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 9,
                    spreadRadius: 3
                  )
                ]
              ),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => page),
                  );
                },
                child: Center(
                  child: Text("See ${topic}",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "Muli",
                        color: Colors.black
                    ),),
                ),
              ),
            ),
          ),
          //...top circlular image part,
        ],
      ),
    );
  }
}

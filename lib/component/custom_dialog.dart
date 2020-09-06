import 'package:flutter/material.dart';
import 'package:easy_blood/constant.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final String image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
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
    return Stack(
      children: <Widget>[
        Container(
          height: 500,
          width: 500,
          padding: EdgeInsets.only(
            top: avatarRadius + padding,
            bottom: padding,
            left: padding,
            right: padding,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xffffbcaf), kGradient2]),
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
                  fontSize: 24.0,
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
        image=="assets/images/whydonateblood.gif"
            ? Positioned(
          left: 80,
        top: 369,
        child: Container(
          height: 170,
          width: 170,
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
        )

            :
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            backgroundColor: kGradient1.withOpacity(0.7),
            radius: 59,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: kGradient2,
              backgroundImage: AssetImage(image),
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

        //...top circlular image part,
      ],
    );
  }
}

import 'package:easy_blood/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BloodGroupInput extends StatefulWidget {
  @override
  _BloodGroupInputState createState() => _BloodGroupInputState();
}

class _BloodGroupInputState extends State<BloodGroupInput> {
  TextEditingController _bloodGroupController = TextEditingController();
  String dropdownValue = 'One';
  String val;
  bool choose = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var dropdownValue;
    return Scaffold(body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Enter your blood group", style: TextStyle(
            fontSize: 18,
            fontFamily: "Muli",
            fontWeight: FontWeight.bold
          ),),
          Center(
            child: Container(
              width: size.width*0.8,
              child: Container(
                child: DropdownButton<String>(

                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        choose = true;
                        dropdownValue = newValue;
                        val=newValue;
                        print(dropdownValue);
                      });
                    },
                  iconSize: 24,
                  elevation: 1,
                  style: TextStyle(color: kPrimaryColor),
                  underline: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width:0.5,style: BorderStyle.solid,color: Colors.black.withOpacity(0.1)),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),

                  )
                    )

                  ),
                  items: <String>['AB', 'A', 'B', 'O']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                    child: Text(value),
                  );
                  }).toList(),
                )
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 12)
                ]
            ),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),

              onPressed: (){

              },
              child: Text("CONFIRM", style: TextStyle(
                fontFamily: "Muli",
                fontSize: 15
              ),),
            ),
          )
        ],
      ),
    ));
  }
}

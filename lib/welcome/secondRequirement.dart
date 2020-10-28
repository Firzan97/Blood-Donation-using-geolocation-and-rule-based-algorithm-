import 'package:easy_blood/constant/constant.dart';
import "package:flutter/material.dart";

class SecondRequirement extends StatefulWidget {
  @override
  _SecondRequirementState createState() => _SecondRequirementState();
}

class _SecondRequirementState extends State<SecondRequirement> {
  var feelingWell=false,testBlood=false,dentalTreatment=false,takenAlcohol=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      child: Container(
        decoration: BoxDecoration(color: kGradient1,image: DecorationImage(
            image: AssetImage("assets/images/bloodcell.png",)),),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(child: Text("Donor Requirement",style: TextStyle(
                  fontSize: size.width*0.05
              ),)),
              SizedBox(height: size.height*0.03,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("This is the last step before you can proceed to donate"),
              ),
              SizedBox(height: size.height*0.03,),
              Text("Are you feeling well today?",style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "Muli",
                  color: Colors.black,
                  fontSize: size.width*0.036)),
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: feelingWell,
                    onChanged: (val) {
                      setState(() {
                        feelingWell = val;

                      });
                    },
                  ),
                  Text("No"),
                  Radio(
                    value: true,
                    groupValue: feelingWell,
                    onChanged: (val) {
                      setState(() {
                        feelingWell = val;
                      });
                    },
                  ),
                  Text("Yes")
                ],
              ),
              Text("Do you donate to test your blood for HIV, Hepatitis and / or Syphilis?",style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "Muli",
                  color: Colors.black,
                  fontSize: size.width*0.036)),
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: testBlood,
                    onChanged: (val) {
                      setState(() {
                        testBlood = val;

                      });
                    },
                  ),
                  Text("No"),
                  Radio(
                    value: true,
                    groupValue: testBlood,
                    onChanged: (val) {
                      setState(() {
                        testBlood = val;
                      });
                    },
                  ),
                  Text("Yes")
                ],
              ),
              Text("Have you received dental treatment in the last 24 hours?",style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "Muli",
                  color: Colors.black,
                  fontSize: size.width*0.036)),
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: dentalTreatment,
                    onChanged: (val) {
                      setState(() {
                        dentalTreatment = val;

                      });
                    },
                  ),
                  Text("No"),
                  Radio(
                    value: true,
                    groupValue: dentalTreatment,
                    onChanged: (val) {
                      setState(() {
                        dentalTreatment = val;
                      });
                    },
                  ),
                  Text("Yes")
                ],
              ),
              Text("In the last 24 hours have you taken alcohol to the point of intoxication?",style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "Muli",
                  color: Colors.black,
                  fontSize: size.width*0.036)),
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: takenAlcohol,
                    onChanged: (val) {
                      setState(() {
                        takenAlcohol = val;

                      });
                    },
                  ),
                  Text("No"),
                  Radio(
                    value: true,
                    groupValue: takenAlcohol,
                    onChanged: (val) {
                      setState(() {
                        takenAlcohol = val;
                      });
                    },
                  ),
                  Text("Yes")
                ],
              ),
              Text("Have you received dental treatment in the last 24 hours?",style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "Muli",
                  color: Colors.black,
                  fontSize: size.width*0.036)),
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: dentalTreatment,
                    onChanged: (val) {
                      setState(() {
                        dentalTreatment = val;

                      });
                    },
                  ),
                  Text("No"),
                  Radio(
                    value: true,
                    groupValue: dentalTreatment,
                    onChanged: (val) {
                      setState(() {
                        dentalTreatment = val;
                      });
                    },
                  ),
                  Text("Yes")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

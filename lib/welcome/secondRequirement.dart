import 'dart:convert';

import 'package:easy_blood/profile/edit_profile.dart';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/home/home.dart';
import 'package:easy_blood/loadingScreen.dart';
import "package:flutter/material.dart";
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondRequirement extends StatefulWidget {
  @override
  _SecondRequirementState createState() => _SecondRequirementState();
}

class _SecondRequirementState extends State<SecondRequirement> {
  var feelingWell=false,testBlood=false,dentalTreatment=false,takenAlcohol=false;
  var menstruating=false,pregnant=false,breastfeed=false,pr;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Loading....',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: LoadingScreen(),
        elevation: 20.0,
        insetAnimCurve: Curves.elasticOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400,fontFamily: "Muli"),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600, fontFamily: "Muli")
    );
    return Material(
      child: Container(
        decoration: BoxDecoration(color: kGradient1,image: DecorationImage(
            image: AssetImage("assets/images/bloodcell.png",)),),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Text("To be answered by female donors only",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "Muli",
                            color: Colors.black,
                            fontSize: size.width*0.036)),
                        Container(
                          height: size.height*0.04,
                          child: CheckboxListTile(
                            title: Text("a) Are you menstruating now?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: menstruating,
                            onChanged: (newValue) {
                              setState(() {
                                menstruating = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                        ),
                        Container(
                          height: size.height*0.04,
                          child: CheckboxListTile(
                            title: Text("b) Are you pregnant or possibly pregnant?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: pregnant,
                            onChanged: (newValue) {
                              setState(() {
                                pregnant= newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                        ),
                        Container(
                          height: size.height*0.06,
                          child: CheckboxListTile(
                            title: Text("c) Do you have a child who is still breastfeeding?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: breastfeed,
                            onChanged: (newValue) {
                              setState(() {
                                breastfeed = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                        ),
                        SizedBox(height: size.height*0.03,),

                      ],
                    ),
                  ),
                ),
                ButtonRound(
                  color: Color(0XFF343a69),
                  text: "CONFIRM",
                  press: ()  {
                    pr.show();
                    _updateQualification();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateQualification() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user =jsonDecode(localStorage.getString("user"));

    var data ={
      "feelingWell": feelingWell==true ? "feeling well today" : "not feeling well today",
      "testBlood": testBlood==true ? "to test blood" : "not to test blood",
      "dentalTreatment": dentalTreatment==true ? "received dental treatment" : "not receive dental treatment",
      "takenAlcohol": takenAlcohol ==true ? "have consume alcohol" : "not consume alcohol",
      "menstruating": menstruating==true ? "have menstruating" : "not menstruating",
      "pregnant": pregnant==true ? "possible pregnant" : "not pregnant",
      "breastfeed": breastfeed==true ? "still breastfeeding" : "not breastfeeding"
    };
    var res = await Api().updateData(data, "${user['_id']}/qualification");
    if(res.statusCode==200){
      pr.hide();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EditProfile()),
      );
    }
  }
}

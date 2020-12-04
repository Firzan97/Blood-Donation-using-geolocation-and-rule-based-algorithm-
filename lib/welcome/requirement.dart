import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/button_round.dart';
import 'package:easy_blood/component/input_round.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/welcome/secondRequirement.dart';
import "package:flutter/material.dart";
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequirementForm extends StatefulWidget {
  @override
  _RequirementFormState createState() => _RequirementFormState();
}

class _RequirementFormState extends State<RequirementForm> {
  final _formKey = GlobalKey<FormState>();

  var lastDonation,dropdownValue,pr;
  bool checkedDenggi,receiveVaccine,misscariage, takeAntibiotic,piercedCuppingAcupuntureTattoo;
  List<String> deaseseList= ["Diabetes","Asthma","Hepatitis B","HIV","Sawan","Sakit Jantung","Darah Tinggi","Dont have all these desease"];
   bool surgical=false;
   bool tranfussion=false;
   bool injury=false;
  var checkedValueFemale=false;
  var CJD1=false,CJD2=false,CJD3=false,sexWithMan=false,mayInfectedHIV=false,testedPositiveHIV=false, infectedHIV=false,fallAboveCategories=false,newSexPartner=false;
  var injectedDrug=false;
  var sexWithProstitute=false;
  var paidReceivedPayment=false;
  var sexPartner=false;
  TextEditingController _beautyInjection = new TextEditingController();
  TextEditingController _problemController= new TextEditingController();
  var lastBeautyInjection=false;
  TextEditingController familyHavingHepatitis= new TextEditingController();
  var lastInfectedDengue=false;
  var lastMisscariage=false;
  var lastAntibiotic=false;
  var lastPiercedCuppingAcupuntureTattoo=false;
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
          image: AssetImage("assets/images/bloodcell.png",)
        )),
        child: SingleChildScrollView(
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
                  child: Text("You need to fill in the form first before using the app. Thank you"),
                ),
                SizedBox(height: size.height*0.03,),
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2020, 3, 5),
                            maxTime: DateTime(2029, 6, 7),
                            theme: DatePickerTheme(
                                headerColor: kPrimaryColor,
                                backgroundColor: kThirdColor,
                                itemStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                            onChanged: (date) {
                              print('change $date in time zone ' +
                                  date.timeZoneOffset.inHours.toString());
                            }, onConfirm: (date) {
                          setState(() {
                            lastDonation = date;

                          });
                              print('confirm ${date}');
                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.date_range),
                          Text(
                            'When is your last donation date?',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: size.height*0.03,),
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(
                        left: 20.0),
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      focusColor:
                      Colors.lightBlue,
                      value: dropdownValue,
                      icon: Icon(
                        Icons.unfold_more,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      hint: Text(
                        "Do yo have any of this desease",
                        style: TextStyle(
                            fontSize: size.width *
                                0.035,
                        color: Colors.black
                        ),
                      ),
                      iconSize: 24,
                      style: TextStyle(
                          color: Colors.black),
                      onChanged:
                          (String newValue) {
                        setState(() {
                          dropdownValue =
                              newValue;
                        });
                      },
                      items: deaseseList.map<
                          DropdownMenuItem<
                              String>>(
                              (String value) {
                            return DropdownMenuItem<
                                String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.03,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          lastDonation!=null ? Column(
                            children: [
                              Text("Have you ever had problems during and after donating?",style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Muli",
                                  color: Colors.black,
                                  fontSize: size.width*0.036)),
                              TextField(
                                controller: _problemController,
                                style: TextStyle(
                                    fontFamily: "Muli",
                                    fontSize: size.width*0.033

                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'State your problems',
                                  hintStyle: TextStyle(fontSize: size.width*0.035),),
                              ),
                            ],
                          ) : SizedBox(),
                          Text("Have you received an immunization injection or any form of beauty injection (eg: botox, collagen) in the last 4 weeks?",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                          TextField(
                            controller: _beautyInjection,
                            style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            ),

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'If so, please state the type and / or purpose',
                              hintStyle: TextStyle(fontSize: size.width*0.035),),
                          ),
//                          Container(
//                            width: 300,
//                            height: 40,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(20)
//                            ),
//                            child: FlatButton(
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(20)
//                                ),
//                                onPressed: () {
//                                  DatePicker.showDatePicker(context,
//                                      showTitleActions: true,
//                                      minTime: DateTime(2020, 3, 5),
//                                      maxTime: DateTime(2029, 6, 7),
//                                      theme: DatePickerTheme(
//                                          headerColor: kPrimaryColor,
//                                          backgroundColor: kThirdColor,
//                                          itemStyle: TextStyle(
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontSize: 18),
//                                          doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//                                      onChanged: (date) {
//                                        print('change $date in time zone ' +
//                                            date.timeZoneOffset.inHours.toString());
//                                      }, onConfirm: (date) {
//                                        setState(() {
//                                           lastBeautyInjection = date;
//
//                                        });
//                                        print('confirm ${date}');
//                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
//                                },
//                                child: Row(
//                                  children: <Widget>[
//                                    Icon(Icons.date_range),
//                                    Text(
//                                      'When is your last donation date?',
//                                      style: TextStyle(color: Colors.black),
//                                    ),
//                                  ],
//                                )),
//                          ),
                          Text("Has anyone in your family ever had or are being treated for Hepatitis B or Hepatitis C?",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                          TextField(
                            controller: familyHavingHepatitis,
                            style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'If so, please state your relationship with him',
                              hintStyle: TextStyle(fontSize: size.width*0.035),),
                          ),
                          Text("Do you have denggue during last 6 months?",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                          Row(
                            children: [
                              Radio(
                                value: false,
                                groupValue: checkedDenggi,
                                onChanged: (val) {
                                  setState(() {
                                    checkedDenggi = val;

                                  });
                                },
                              ),
                              Text("No"),
                              Radio(
                                value: true,
                                groupValue: checkedDenggi,
                                onChanged: (val) {
                                  setState(() {
                                    checkedDenggi = val;
                                  });
                                },
                              ),
                              Text("Yes")
                            ],
                          ),
//                          Container(
//                            width: 300,
//                            height: 40,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(20)
//                            ),
//                            child: FlatButton(
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(20)
//                                ),
//                                onPressed: () {
//                                  DatePicker.showDatePicker(context,
//                                      showTitleActions: true,
//                                      minTime: DateTime(2020, 3, 5),
//                                      maxTime: DateTime(2029, 6, 7),
//                                      theme: DatePickerTheme(
//                                          headerColor: kPrimaryColor,
//                                          backgroundColor: kThirdColor,
//                                          itemStyle: TextStyle(
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontSize: 18),
//                                          doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//                                      onChanged: (date) {
//                                        print('change $date in time zone ' +
//                                            date.timeZoneOffset.inHours.toString());
//                                      }, onConfirm: (date) {
//                                        setState(() {
//                                          lastInfectedDengue = date;
//
//                                        });
//                                        print('confirm ${date}');
//                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
//                                },
//                                child: Row(
//                                  children: <Widget>[
//                                    Icon(Icons.date_range),
//                                    Text(
//                                      'When is the date you get well from dengue?',
//                                      style: TextStyle(color: Colors.black),
//                                    ),
//                                  ],
//                                )),
//                          ),
                          Text("Do you receive vaccine during last 3 months?",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                          Row(
                            children: [
                              Radio(
                                value: false,
                                groupValue: receiveVaccine,
                                onChanged: (val) {
                                  setState(() {
                                    receiveVaccine = val;

                                  });
                                },
                              ),
                              Text("No"),
                              Radio(
                                value: true,
                                groupValue: receiveVaccine,
                                onChanged: (val) {
                                  setState(() {
                                    receiveVaccine = val;

                                  });
                                },
                              ),
                              Text("Yes")
                            ],
                          ),
                          Text("Have you given birth or had a miscarriage in the last 6 months?",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                          Row(
                            children: [
                              Radio(
                                value: false,
                                groupValue: misscariage,
                                onChanged: (val) {
                                  setState(() {
                                    misscariage = val;

                                  });
                                },
                              ),
                              Text("No"),
                              Radio(
                                value: true,
                                groupValue: misscariage,
                                onChanged: (val) {
                                  setState(() {
                                    misscariage = val;

                                  });
                                },
                              ),
                              Text("Yes"),

                            ],
                          ),
//                          Container(
//                            width: 300,
//                            height: 40,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(20)
//                            ),
//                            child: FlatButton(
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(20)
//                                ),
//                                onPressed: () {
//                                  DatePicker.showDatePicker(context,
//                                      showTitleActions: true,
//                                      minTime: DateTime(2020, 3, 5),
//                                      maxTime: DateTime(2029, 6, 7),
//                                      theme: DatePickerTheme(
//                                          headerColor: kPrimaryColor,
//                                          backgroundColor: kThirdColor,
//                                          itemStyle: TextStyle(
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontSize: 18),
//                                          doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//                                      onChanged: (date) {
//                                        print('change $date in time zone ' +
//                                            date.timeZoneOffset.inHours.toString());
//                                      }, onConfirm: (date) {
//                                        setState(() {
//                                          lastMisscariage = date;
//
//                                        });
//                                        print('confirm ${date}');
//                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
//                                },
//                                child: Row(
//                                  children: <Widget>[
//                                    Icon(Icons.date_range),
//                                    Text(
//                                      'When is the date you missacariage?',
//                                      style: TextStyle(color: Colors.black),
//                                    ),
//                                  ],
//                                )),
//                          ),
                          Text("In the last 6 months, have you ever:  ",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),

                          Container(
                            height: size.height*0.04,
                            child: CheckboxListTile(
                              title: Text("Undergo any surgical treatment",style: TextStyle(
                                  fontFamily: "Muli",
                                  fontSize: size.width*0.033

                              )),
                              value: surgical,
                              onChanged: (newValue) {
                                setState(() {
                                  surgical = newValue;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading, //
                            ),
                          ),
                          Container(
                            height: size.height*0.04,
                            child: CheckboxListTile(
                              title: Text("Receiving blood transfusions",style: TextStyle(
                                  fontFamily: "Muli",
                                  fontSize: size.width*0.033

                              )),
                              value: tranfussion,
                              onChanged: (newValue) {
                                setState(() {
                                 tranfussion= newValue;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading, //
                            ),
                          ),
                          Container(
                            height: size.height*0.04,
                            child: CheckboxListTile(
                              title: Text("Getting an accidental needle injury",style: TextStyle(
                                  fontFamily: "Muli",
                                  fontSize: size.width*0.033

                              )),
                              value: injury,
                              onChanged: (newValue) {
                                setState(() {
                                  injury = newValue;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading, //
                            ),
                          ),
                          SizedBox(height: size.height*0.03,),

                          Text("Do you pierced, cupping, acupuncture or tattoo during last 6 months?",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                          Row(
                            children: [
                              Radio(
                                value: false,
                                groupValue: piercedCuppingAcupuntureTattoo,
                                onChanged: (val) {
                                  setState(() {
                                    piercedCuppingAcupuntureTattoo= val;

                                  });
                                },
                              ),
                              Text("No"),
                              Radio(
                                value: true,
                                groupValue: piercedCuppingAcupuntureTattoo,
                                onChanged: (val) {
                                  setState(() {
                                    piercedCuppingAcupuntureTattoo = val;

                                  });
                                },
                              ),
                              Text("Yes")
                            ],
                          ),
//                          Container(
//                            width: 300,
//                            height: 40,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(20)
//                            ),
//                            child: FlatButton(
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(20)
//                                ),
//                                onPressed: () {
//                                  DatePicker.showDatePicker(context,
//                                      showTitleActions: true,
//                                      minTime: DateTime(2020, 3, 5),
//                                      maxTime: DateTime(2029, 6, 7),
//                                      theme: DatePickerTheme(
//                                          headerColor: kPrimaryColor,
//                                          backgroundColor: kThirdColor,
//                                          itemStyle: TextStyle(
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontSize: 18),
//                                          doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//                                      onChanged: (date) {
//                                        print('change $date in time zone ' +
//                                            date.timeZoneOffset.inHours.toString());
//                                      }, onConfirm: (date) {
//                                        setState(() {
//                                          lastPiercedCuppingAcupuntureTattoo = date;
//
//                                        });
//                                        print('confirm ${date}');
//                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
//                                },
//                                child: Row(
//                                  children: <Widget>[
//                                    Icon(Icons.date_range),
//                                    Text(
//                                      'When is the date you missacariage?',
//                                      style: TextStyle(color: Colors.black),
//                                    ),
//                                  ],
//                                )),
//                          ),
                          Text("Take antiobiotic drugs 2 weeks before donating blood",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                          Row(
                            children: [
                              Radio(
                                value: false,
                                groupValue: takeAntibiotic,
                                onChanged: (val) {
                                  setState(() {
                                    takeAntibiotic = val;

                                  });
                                },
                              ),
                              Text("No"),
                              Radio(
                                value: true,
                                groupValue: takeAntibiotic,
                                onChanged: (val) {
                                  setState(() {
                                    takeAntibiotic = val;

                                  });
                                },
                              ),
                              Text("Yes")
                            ],
                          ),
//                          Container(
//                            width: 300,
//                            height: 40,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(20)
//                            ),
//                            child: FlatButton(
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(20)
//                                ),
//                                onPressed: () {
//                                  DatePicker.showDatePicker(context,
//                                      showTitleActions: true,
//                                      minTime: DateTime(2020, 3, 5),
//                                      maxTime: DateTime(2029, 6, 7),
//                                      theme: DatePickerTheme(
//                                          headerColor: kPrimaryColor,
//                                          backgroundColor: kThirdColor,
//                                          itemStyle: TextStyle(
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontSize: 18),
//                                          doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//                                      onChanged: (date) {
//                                        print('change $date in time zone ' +
//                                            date.timeZoneOffset.inHours.toString());
//                                      }, onConfirm: (date) {
//                                        setState(() {
//                                          lastAntibiotic = date;
//
//                                        });
//                                        print('confirm ${date}');
//                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
//                                },
//                                child: Row(
//                                  children: <Widget>[
//                                    Icon(Icons.date_range),
//                                    Text(
//                                      'When is the date you take antibiotic?',
//                                      style: TextStyle(color: Colors.black),
//                                    ),
//                                  ],
//                                )),
//                          ),
                          Text("Risiko jangkitan variant Creutzfeldt-Jakob Disease (vCJD)",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                          CheckboxListTile(
                            title: Text("a) Pernahkah anda melawat atau menetap di United Kingdom (England, Ireland Utara, Wales, Scotland, Isle of Man, Channel Island) atau Republik Ireland untuk tempoh terkumpul 6 bulan atau lebih di antara 1hb Januari 1980 hingga 31hb Disember 1996 ?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: CJD1,
                            onChanged: (newValue) {
                              setState(() {
                                CJD1 = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("b) Pernahkah anda menerima transfusi atau suntikan darah atau produk darah sewaktu berada di United Kingdom diantara 1hb Januari 1980 hingga sekarang ?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: CJD2,
                            onChanged: (newValue) {
                              setState(() {
                                CJD2 = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("c) Pernahkah anda melawat atau menetap di negara-negara Eropah berikut* untuk tempoh terkumpul 5 tahun atau lebih antara 1hb Januari 1980 hingga sekarang (* Austria, Belanda, Belgium, Denmark, Finland, Greece, Jerman, Itali, Liechtenstein, Luxembourg, Norway, Perancis, Portugal, Sepanyol, Sweden dan Switzerland) ?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: CJD3,
                            onChanged: (newValue) {
                              setState(() {
                                CJD3 = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          Text("For the sake of patient safety, the following questions MUST be answered HONESTLY, even if it only involves you once.",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                          CheckboxListTile(
                            title: Text("a) If you are a man, have you ever had sex with another man?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: sexWithMan,
                            onChanged: (newValue) {
                              setState(() {
                                sexWithMan = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("b) Have you ever had sex with a commercial sex worker (prostitute)?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: sexWithProstitute,
                            onChanged: (newValue) {
                              setState(() {
                                sexWithProstitute = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("c) Have you ever paid or received payment for sex?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: paidReceivedPayment,
                            onChanged: (newValue) {
                              setState(() {
                                paidReceivedPayment = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("Have you ever had more than one sex partner?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: sexPartner,
                            onChanged: (newValue) {
                              setState(() {
                                sexPartner = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("e) Have you had a new sex partner in the last 12 months?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: newSexPartner,
                            onChanged: (newValue) {
                              setState(() {
                                newSexPartner = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("f) Have you ever injected yourself with illicit drugs, including bodybuilding drugs?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: injectedDrug,
                            onChanged: (newValue) {
                              setState(() {
                                injectedDrug = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("g) Does your sex partner fall into any of the above categories?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: fallAboveCategories,
                            onChanged: (newValue) {
                              setState(() {
                                fallAboveCategories = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("h) Have you or your sex partner ever been tested positive for HIV?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                           value: testedPositiveHIV,
                            onChanged: (newValue) {
                              setState(() {
                                testedPositiveHIV = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          CheckboxListTile(
                            title: Text("i) Do you think you or your sex partner may be infected with HIV?",style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: size.width*0.033

                            )),
                            value: mayInfectedHIV,
                            onChanged: (newValue) {
                              setState(() {
                                mayInfectedHIV = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading, //
                          ),
                          Text("Please update this form if there are any of the qualification you have pass",style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Muli",
                              color: Colors.black,
                              fontSize: size.width*0.036)),
                        ],
                      ),
                    ),
                  ),
                ),

                ButtonRound(
                  color: Color(0XFF343a69),
                  text: "CONFIRM",
                  press: ()  {
                    pr.show();
                    _createQualification();
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _createQualification()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString("user"));
    var data={
      "lastDonation": lastDonation.toString(),
      "desease": dropdownValue,
      "problem": _problemController.text!="" ? _problemController.text : "no donation problem",
      "beautyInjection": _beautyInjection.text!="" ? _beautyInjection.text : "nobeauty injection",
//      "lastInjection": lastBeautyInjection,
      "familyHavingHepatitis": familyHavingHepatitis.text!="" ?familyHavingHepatitis.text : "no family having hepatitis" ,
      "dengue": checkedDenggi==true ? "have dengue" : "have no dengue",
//      "lastInfectedDengue": lastInfectedDengue,
      "receiveVaccine": receiveVaccine==true ? "receive vaccine" : "not receive vaccine",
//      "dateReceiveVaccine": receiveVaccine,
      "misscariage": misscariage==true ? "have misscariage" : "have no misscariage",
//      "dateMisscariage": lastMisscariage,
      "pierceCuppingAcupuntureTattoo": piercedCuppingAcupuntureTattoo==true ? "have piercedCuppingAcupuntureTattoo" : "have not piercedCuppingAcupuntureTattoo",
//      "datepierceCuppingAcupuntureTattoo": lastPiercedCuppingAcupuntureTattoo,
      "takeAntiobiotic": takeAntibiotic==true ? "have take antibiotic" : "not take antibiotic",
//      "dateTakeAntibiotic": lastAntibiotic,
    "surgical": surgical==true ? "have surgical" : "have no surgical",
      "injury": injury==true ? "have injury" : "have no injury",
      "transfussion": tranfussion==true ? "have blood transfussion" : "have no blood transfussion",
      "CJD1": CJD1==true ? "have experience CJD1 " : "have no experience CJD1",
      "CJD2": CJD2==true ? "have experience CJD2" : "have no experience CJD2",
      "CJD3": CJD3==true ? "have experience CJD3" : "have no experience CJD3",
      "sexWithMan": sexWithMan==true ? "have sex with man" : "never have sex with man",
      "sexWithProstitute": sexWithProstitute==true ? "have sex with prostitute" : "never have sex with prostitute",
      "paidOrPaySex": paidReceivedPayment==true ? "have paid or pay sex" : "never have paid or pay sex",
      "sexPartnerNumber": sexPartner==true ? "have several sex partner" : "have no sex partner",
      "sexPArnerLast12Month": newSexPartner==true ? "have sex partner last 12 month" : "have no sex partner last 12 month",
      "injectDrug": injectedDrug==true ? "have injected drug" : "have no injectewd drug",
      "partnerCatagories": fallAboveCategories==true ? "fall above categories" : "not fall above categories",
      "partnerHIVpositive": testedPositiveHIV==true ? "have tested positive HIV" : "have tested not positive HIV",
      "youOrSexPartnerHIVinfected": mayInfectedHIV==true ? "may infected HIV " : "not infected HIV",
    };
    var res = await Api().postData(data,"${user['_id']}/qualification");
   if(res.statusCode==200){
     print("suksess");
pr.hide();
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondRequirement()),
);
   }

  }
}

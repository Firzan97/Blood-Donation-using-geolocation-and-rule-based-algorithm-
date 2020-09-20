import 'dart:convert';
import 'dart:io';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/profile/profile.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:easy_blood/welcome/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var user;
  bool checkedValueFemale = false;
  bool checkedValueMale = false;
  String dropdownValue ;
  File _image;
  final picker = ImagePicker();
  String base64Image;
  File tmpFile;
  String status = "";
  String errMessage = "error Upload Image";
  String uploadEndPoint = "";
  static double latitude=0.0;
  static double longitude=0.0;
  var addresses;
  var first;
  TextEditingController _mobileController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  var pr;

  getUserAddress()async{
    final coordinates = new Coordinates(latitude, longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
  }

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
      tmpFile = _image;
      base64Image = base64Encode(tmpFile.readAsBytesSync());
      uploadEndPoint = "http://laraveleasyblood-env.eba-kezjpqpc.ap-southeast-1.elasticbeanstalk.com/api/user/${user['_id']}";
    });
    print(base64Image);
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      tmpFile = _image;
      base64Image = base64Encode(tmpFile.readAsBytesSync());
      uploadEndPoint = "http://laraveleasyblood-env.eba-kezjpqpc.ap-southeast-1.elasticbeanstalk.com/api/user/${user['_id']}";
    });
    print(base64Image);
  }

  setStatus(String message){
    setState(() {
      status = message;
    });

    print(status);
  }

  startUpload(){
    if(null == tmpFile){
      setStatus(errMessage);
      return;
    }
    String filename = tmpFile.path.split('/').last;
//    upload(filename);
  }

  upload(){
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    pref.setString("user", null);
//    var email2=pref.getString("_id");
  var gender;
  if(checkedValueMale==true){
    gender = "Male";
  }
  else{
    gender="female";
  }
    http.put(uploadEndPoint, body: {
      "image": base64Image!=null ? base64Image : "" ,
      "latitude": latitude!=null ? latitude.toString() : user['latitude'].toString(),
      "longitude": longitude!=null ? longitude.toString() : user['longitude'].toString() ,
      "bloodType": dropdownValue!=null ? dropdownValue : user['bloodType'].toString(),
      "gender": (checkedValueFemale!=true && checkedValueMale!=true) ?  user['gender'].toString() : gender,
      "phoneNumber": _mobileController.text!="" ? _mobileController.text : user['phoneNumber'].toString(),
      "height": _heightController.text!="" ? _heightController.text : user['height'].toString(),
      "weight": _weightController.text!="" ? _weightController.text : user['weight'].toString()
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
      pr.hide();
    }).catchError((error) {
      setStatus(error);
    });
  }

  void getUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(localStorage.getString("user"));
      uploadEndPoint = "http://laraveleasyblood-env.eba-kezjpqpc.ap-southeast-1.elasticbeanstalk.com/api/user/${user['_id']}";
    });
  }

  void getUserLocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  @override
  void initState(){
    getUserData();
    super.initState();
    getUserLocation();
//    getUserAddress();

  }

  @override
  Widget build(BuildContext context) {
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
    Size size = MediaQuery.of(context).size;
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: size.width*1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [kGradient1, kGradient2]),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.arrow_back),onPressed: (){Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile()),
                    );},),
                    SizedBox(width: size.width*0.27,),
                    Text("Edit Profile"),
                  ],
                ),
                Container(
                  width: size.width*1,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 9,
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 3
                                )
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: user!=null ? user['imageURL']==null  ? NetworkImage('https://easy-blood.s3-ap-southeast-1.amazonaws.com/loadProfileImage.png') : NetworkImage(user['imageURL']) : NetworkImage('https://easy-blood.s3-ap-southeast-1.amazonaws.com/loadProfileImage.png')
                              )
                          ),
                        ),
                      ),

                      Column(
                        children: <Widget>[
                          SizedBox(height: size.height*0.2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: kPrimaryColor, // button color
                                  child: InkWell(
                                    splashColor: Colors.black, // inkwell color
                                    child: SizedBox(width: 36, height: 36, child: Icon(Icons.photo_library)),
                                    onTap: () {
                                      getImageGallery();


                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width*0.03,),
                              ClipOval(
                                child: Material(
                                  color: kPrimaryColor, // button color
                                  child: InkWell(
                                    splashColor: Colors.black, // inkwell color
                                    child: SizedBox(width: 36, height: 36, child: Icon(Icons.camera_alt)),
                                    onTap: () {
                                      getImageCamera();

                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 4,
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 13)
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Current Location"),
                        Container(
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 9,
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 3
                              )
                            ],
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text("Locate",style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: "Muli",
                                color: Colors.black
                            ),),onPressed: (){
                            getUserLocation();
                            getUserAddress();
                          },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        first==null ? Text("your address") : Text("${first.addressLine}"),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text("Username"),
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter username'),
                        ),
                        Text("Email"),
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter email'),
                        ),
                        Text("Gender"),
                        CheckboxListTile(
                          title: Text("Male"),
                          secondary: FaIcon(FontAwesomeIcons.male),
                          value: checkedValueMale,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValueMale = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading, //
                        ),
                        CheckboxListTile(
                          title: Text("Female"),
                          secondary: FaIcon(FontAwesomeIcons.female),
                          value: checkedValueFemale,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValueFemale = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading, //
                        ),
                        Text("Blood Group"),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['A', 'B', 'AB', 'O']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Text("Mobile Number"),
                        TextField(
                          controller: _mobileController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter mobile number'),
                        ),
                        Text("Height"),
                        TextField(
                          controller: _heightController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter height'),
                        ),
                        Text("Weight"),
                        TextField(
                          controller: _weightController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter weight'),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 160,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 3,
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 9)
                                  ]),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text("CANCEL"),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 160,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 4,
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 9)
                                  ]),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text("CONFIRM"),
                                onPressed: () {
                                  pr.show();
                                  upload();
                                  fetchUser();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),),
    );
  }

  bool checkIfAnyIsNull() {
    return [user['imageURL'],
      user['email'],
      user['username'],
      user['age'],
      user['gender'],
      user['bloodType'],
      user['height'],
      user['imageURL'],
      user['latitude'],
      user['longitude'],
      user['phoneNumber'],
      user['weight']].contains("");
  }

  Future<String> fetchUser() async {
    await Future.delayed(const Duration(seconds: 10));
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var res = await Api().getData("user/${user['_id']}");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      setState(() {
        localStorage.setString("user", json.encode(body));
        user = jsonDecode(localStorage.getString("user"));
        localStorage.setBool("statusUpdated", checkIfAnyIsNull());

      });
      return localStorage.getString("user");
    } else {
      throw Exception('Failed to load user');
    }
  }

}

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/curvedBackground.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/home.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/event.dart';
import 'package:easy_blood/model/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<List<Requestor>> _future;

  File _image;
  final picker = ImagePicker();
  String base64Image;
  File tmpFile;
  String status = "";
  String errMessage = "error Upload Image";
  String uploadEndPoint = "";
  var user;
  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      tmpFile=_image;
      base64Image = base64Encode(tmpFile.readAsBytesSync());
      uploadEndPoint="http://192.168.1.6:8000/api/user/${user['_id']}";
    });
    print(base64Image);
  }

  setStatus(String message){
    setState(() {
      status = message;
    });

    print("ssasas");
  }
  startUpload(){
  if(null == tmpFile){
    setStatus(errMessage);
    return;
  }
  String filename = tmpFile.path.split('/').last;
  upload(filename);
  }

  upload(String fileName){
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    pref.setString("user", null);
//    var email2=pref.getString("_id");
    http.put(uploadEndPoint,body: {
    "image": base64Image,
    "imageURL": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error){
      setStatus(error);
    });
  }

  Future getImageGalerry() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      tmpFile=_image;
      base64Image = base64Encode(tmpFile.readAsBytesSync());
    });
  }

  void getUserData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(localStorage.getString("user"));
    });
    }
  @override
  void initState(){
    _future = fetchBlood();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(theme: ThemeData(fontFamily: "Muli"),
            home: Scaffold(
          body: Container(
            color: Colors.grey.withOpacity(0.1),
            child: Column(
              children: <Widget>[
                Container(
                  height: size.height*1,
                  child: Stack(
                    children: <Widget>[
                      ClipPath(
                        clipper: MyClipper2(),
                        child: Container(
                          height: size.height * 0.42,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [kGradient2, kGradient1]),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              spreadRadius: 3,
                              color: Colors.black.withOpacity(0.9)
                            )
                          ]),
                        ),
                      ),
                      Opacity(
                        opacity: 0.9,
                        child: Container(
                          height: size.height*1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [kGradient1, kGradient2]),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (){
                                      Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      );
                                    },
                                    icon: Icon(Icons.arrow_back,color: Colors.white,),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.menu,color: Colors.white,),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                child: Container(
                                  height: 100,
                                  child: Stack(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(user['imageURL'])
                                                )
                                            ),
                                          ),
                                          SizedBox(width: size.width*0.05,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Firzan Azrai",style: TextStyle(
                                                  color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold
                                              )),
                                              SizedBox(height: size.height*0.01,),
                                              Text("Joined 3 days ago",style: TextStyle(
                                                color: Colors.black.withOpacity(0.5)
                                              ),),
                                            ],
                                          )
                                        ],
                                      ),
                                      Positioned(
                                        left:60,
                                        top: 10,
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.white, // button color
                                            child: InkWell(
                                              splashColor: Colors.black, // inkwell color
                                              child: SizedBox(width: 36, height: 36, child: Icon(Icons.photo_library)),
                                              onTap: () {
                                                startUpload();

                                              },
                                            ),
                                          ),
                                        )
                                      ),
                                      Positioned(
                                          left:60,
                                          top: 60,
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors.white, // button color
                                              child: InkWell(
                                                splashColor: Colors.black, // inkwell color
                                                child: SizedBox(width: 36, height: 36, child: Icon(Icons.camera_alt)),
                                                onTap: () {
                                                  getImageCamera();

                                                },
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5,bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.location_on),
                                          Text("Tumpat, Kelantan")
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: kPrimaryColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 12
                                          )
                                        ]
                                      ),
                                      child: FlatButton(
                                        onPressed: (){

                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Text("AB+"),
                                        )),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                     color: kGradient1,
                                    boxShadow: [BoxShadow(
                                      blurRadius: 9,
                                      spreadRadius: 3,
                                      color: Colors.black.withOpacity(0.1)
                                    )],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Text("4"),
                                              Text("Blood donated")
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text("4"),
                                            Text("Blood Requested")
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text("Status"),
                                            Text("Eligible to donate")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: 0.10,
                        minChildSize: 0.10,
                        maxChildSize: 0.8,
                        builder: (BuildContext c,s){
                        return Container(
                          height: size.height * 0.2,
                          width: size.width * 1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: SingleChildScrollView(
                            controller: s,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: size.height*0.01),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 30,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black
                                    ),
                                    child: Center(
                                      child: Text("Your Activities",style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Muli",
                                          color: Colors.white
                                      ),),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(19.0),
                                  child: Container(
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          width: size.width * 1,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                spreadRadius: 3,
                                                blurRadius: 12
                                              )
                                            ]
                                              ),
                                          child: Column(
                                            children: <Widget>[
                                               SizedBox(height: size.height*0.03,),
                                              FutureBuilder(
                                                future: _future,
                                                builder: (context,snapshot) {
                                                  if (snapshot.data == null) {
                                                    return Container(
                                                      child: Center(
                                                        child: LoadingScreen(),
                                                      ),
                                                    );
                                                  }
                                                  return Container(
                                                    height: size.height*0.4,
                                                    child: ListView.builder(
                                                        itemCount: snapshot.data.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          return Padding(
                                                            padding: const EdgeInsets
                                                                .all(
                                                                15.0),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  height: 50,
                                                                  width: 60,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                  ),
                                                                  child: ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          5),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/lari2.jpg",
                                                                        fit: BoxFit
                                                                            .cover,)),
                                                                ),
                                                                SizedBox(
                                                                  width: size.width *
                                                                      0.09,),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: <Widget>[
                                                                    Text(
                                                                        "6 hours ago"),
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          child: Text(
                                                                              "Syazwan Asraf"),
                                                                        ),
                                                                        SizedBox(
                                                                          width: size
                                                                              .width *
                                                                              0.08,),
                                                                        Container(
                                                                          child: Row(
                                                                            children: <
                                                                                Widget>[
                                                                              Row(
                                                                                children: <
                                                                                    Widget>[
                                                                                  Icon(
                                                                                      Icons
                                                                                          .thumb_up),
                                                                                  Text(
                                                                                      "1")
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width: size
                                                                                    .width *
                                                                                    0.05,),
                                                                              Row(
                                                                                children: <
                                                                                    Widget>[
                                                                                  Icon(
                                                                                      Icons
                                                                                          .comment),
                                                                                  Text(
                                                                                      "1")
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          );

                                                        }
                                                    ),
                                                  );
                                                }
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: kGradient2
                                          ),
                                          child: Center(
                                            child: Text("Your Requests",style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Muli",
                                                color: Colors.white
                                            ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(19.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: size.height*0.3,
                                        width: size.width * 1,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  spreadRadius: 3,
                                                  blurRadius: 12
                                              )
                                            ]
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(height: size.height*0.03,),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 50,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.rectangle,
                                                      ),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius.circular(5),
                                                          child: Image.asset(
                                                            "assets/images/lari2.jpg",fit: BoxFit.cover,)),
                                                    ),
                                                    SizedBox(width: size.width*0.09,),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text("6 hours ago"),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text("Syazwan Asraf"),
                                                            ),
                                                            SizedBox(width: size.width*0.08,),
                                                            Container(
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <Widget>[
                                                                      Icon(Icons.thumb_up),
                                                                      Text("1")
                                                                    ],
                                                                  ),
                                                                  SizedBox(width: size.width*0.05,),
                                                                  Row(
                                                                    children: <Widget>[
                                                                      Icon(Icons.comment),
                                                                      Text("1")
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 50,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.rectangle,
                                                      ),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius.circular(5),
                                                          child: Image.asset(
                                                            "assets/images/lari2.jpg",fit: BoxFit.cover,)),
                                                    ),
                                                    SizedBox(width: size.width*0.09,),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text("6 hours ago"),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text("Syazwan Asraf"),
                                                            ),
                                                            SizedBox(width: size.width*0.08,),
                                                            Container(
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <Widget>[
                                                                      Icon(Icons.thumb_up),
                                                                      Text("1")
                                                                    ],
                                                                  ),
                                                                  SizedBox(width: size.width*0.05,),
                                                                  Row(
                                                                    children: <Widget>[
                                                                      Icon(Icons.comment),
                                                                      Text("1")
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: kGradient2
                                        ),
                                        child: Center(
                                          child: Text("Lives Saved",style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Muli",
                                              color: Colors.white
                                          ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );}
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
         )
        )
    );
  }
  Future<List<Requestor>> fetchBlood() async {

    var res = await Api().getData("request");
    var bodys = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Requestor> requests = [];
      var count=0;
      for (Map u in bodys) {
        count++;
        print(count);
        print(u);
        Requestor event = Requestor.fromJson(u);
        print('dapat');
        requests.add(event);
      }

      return requests;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Event>> fetchEvent() async {

    var res = await Api().getData("event");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Event> events = [];
      for (Map u in body) {
        Event event = Event.fromJson(u);
        events.add(event);
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }

}

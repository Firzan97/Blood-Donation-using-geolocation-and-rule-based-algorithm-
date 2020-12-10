import 'package:easy_blood/model/request.dart';
import 'package:flutter/material.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_blood/profile/profile.dart';
import 'package:geolocator/geolocator.dart';


class CompatibleDonor extends StatefulWidget {
  final String bloodType;
  final String requestId;
  final String userId;

  const CompatibleDonor({Key key, this.bloodType,this.requestId,this.userId}) : super(key: key);
  @override
  _CompatibleDonorState createState() => _CompatibleDonorState();
}

class _CompatibleDonorState extends State<CompatibleDonor> {
  var currentUser;
  List<double> listDistance=[];

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Compatible Donor"),
        centerTitle: true,
        backgroundColor:kPrimaryColor.withOpacity(0.8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height*0.7,
              width: size.width*1,

              child: FutureBuilder(
                future: findDonor(),
    builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
              child: Center(
                child: LoadingScreen(),
              ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder:
                (BuildContext context, int index) {


              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: size.height*0.26,
                    width: size.width*1,

                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 9,
                                            spreadRadius: 7
                                          )
                                        ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: size.height*0.2,
                              width: size.width*0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data[index].imageURL
                                  )
                                )
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data[index].username,style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Muli"
                                ),),
                                Text(snapshot.data[index].age,style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Muli"
                                ),)
                              ],
                            ),
                          ],
                        ),

                          Container(
                            height: size.height*0.045,
                              width: size.width*0.30,
                              decoration: BoxDecoration(
                                color: kPrimaryColor
                              ),
                              child: FlatButton(child: Text("Received Blood From this user",textAlign:TextAlign.center,style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height*0.015,
                                fontFamily: "Muli"
                              ),),
                              onPressed: (){
                                AwesomeDialog(
                                  context: context,
                                  width: 390,
                                  buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.NO_HEADER,

                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Blood Donor Confirmation',
                                  desc: 'Are you confirm that this donor have donate blood for you?',
                                  btnCancelOnPress: () {
                                    Navigator.of(context, rootNavigator: true).pop();
                                    //Will not exit the App
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CompatibleDonor(bloodType: widget.bloodType,requestId: widget.requestId,)),
                                    );
                                  },
                                  btnOkOnPress: () {
                                    Navigator.of(context, rootNavigator: true).pop();
                                    //Will not exit the App
//                                    deleteRequest(widget.requestId);
                                    receivedDonation(widget.requestId,snapshot.data[index].id);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()),
                                    );
                                  },
                                )..show();
                              },))
                      ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: size.height*0.037,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("Gender: ${snapshot.data[index].gender}",style: TextStyle(
                                    fontSize: size.height*0.015
                                )),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                            Container(
                              height: size.height*0.037,

                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("${snapshot.data[index].phoneNumber}",style: TextStyle(
                                  fontSize: size.height*0.015
                                ),),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                            Container(
                              height: size.height*0.037,

                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.add_location,size: 15,),
                                    Text("${listDistance[index].toString()} KM",style: TextStyle(
                                        fontSize: size.height*0.015
                                    ))
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                color: Colors.green,

                              ),
                            )

                          ],
                        )
                      ],
                    ),
                  )
                ),
              );
          },
        );
    }

    ),
            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Container(
//                height: size.height*0.3,
//                decoration: BoxDecoration(
//                  color: kPrimaryColor,
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.black.withOpacity(0.1),
//                      spreadRadius: 6,
//                      blurRadius: 8
//                    )
//                  ]
//                ),
//              ),
//            )
          ],
        ),
      ),
    );
  }
  Future<void> fetchBloodDonatedCount(donorId) async {
    int count=0;
    var data;
    var res = await Api().getData("user/${donorId}/request");
    var bodys = json.decode(res.body);

    if (res.statusCode == 200) {
      for (Map u in bodys) {

        Requestor req = Requestor.fromJson(u);
        if(req.donor_id==donorId) {
            count++;

        }
      }
      print(count);

      if(count==1){
        data={
          "achievement_id": "5fd180b744710ef17fc8c6cd"
        };

        var res = await Api().postData(data,"userAchievement/${donorId}");

      }
      else if(count==3){
        data={
          "achievement_id": "5fd1814c44710ef17fc8c6ce"
        };
        var res = await Api().postData(data,"userAchievement/${donorId}");
      }
      else if(count==10){
        data={
          "achievement_id": "5fd1817f44710ef17fc8c6cf"
        };
        var res = await Api().postData(data,"userAchievement/${donorId}");
      }
      else if(count==15){
        data={
          "achievement_id": "5fd1819a44710ef17fc8c6d0"
        };
        var res = await Api().postData(data,"userAchievement/${donorId}");
      }
      else if(count==30){
        data={
          "achievement_id": "5fd181bd44710ef17fc8c6d1"
        };
        var res = await Api().postData(data,"userAchievement/${donorId}");
      }

      if(res.statusCode==200){
        print("babiaaaaaaaaaaaaaaaaaa");

      }
    } else {
      throw Exception('Failed to load album');
    }
  }
Future<void> receivedDonation(requestId,donorId) async{
    var data = {
      "requestId": requestId,
      "donorId": donorId
    };
    print(data);
  var res = await Api().updateData(data,"request/donor");
  print(res.statusCode);
  if(res.statusCode==200){
    print("Yess berjaya sudahh");
    fetchBloodDonatedCount(donorId);
  }

}

 Future<void> getCurrentUser() async{
   SharedPreferences localStorage = await SharedPreferences.getInstance();
   setState(() {
      currentUser =jsonDecode(localStorage.getString("user"));
      print(currentUser);
   });
 }

  Future<void> deleteRequest(id)async{
    var res = await Api().deleteData("request/${id}");
    if(res.statusCode==200){
      print("Request have been deleted");
    }

  }

  Future<List<User>> findDonor() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var res = await Api().getData("${widget.bloodType}/findDonor");
    print(widget.bloodType);
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      List<User> users = [];
      for (var u in body) {
        User user = User.fromJson(u);
        if(user.id!=currentUser["_id"]) {
//        print(double.parse(currentUser['latitude']));
//        print(double.parse(currentUser['longitude']));
//        print(user.latitude);
//        print(user.longitude.runtimeType);
        var distanceInMeters = await Geolocator().distanceBetween(double.parse(currentUser['latitude']),double.parse(currentUser['longitude']),user.latitude, user.longitude);
        print(distanceInMeters);
//        print(user.username);
                              listDistance.add(distanceInMeters/1000);
          users.add(user);

        }
      }
      return users;
    } else {
      throw Exception('Failed to load album');
    }
  }

}

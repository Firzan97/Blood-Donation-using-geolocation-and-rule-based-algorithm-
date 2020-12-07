import 'dart:async';
import 'dart:convert';
import 'package:easy_blood/admin/user/add_admin.dart';
import 'package:easy_blood/admin/user/add_user.dart';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/admin.dart' ;

import 'package:easy_blood/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Muli"
      ),
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("EASY BLOOD")),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            bottom: TabBar(
              indicatorColor: Colors.white,

              isScrollable: true,
              tabs: choices.map<Widget>((Choice choice)
              {
                return Tab(
                  text: choice.title,
                );
              }).toList(),
            ),

          ),
          body:TabBarView(
              children: choices.map((Choice choice){
                return ChoicePage(
                  choice: choice,
                );
              }).toList()
          )
          ),
      ));
  }




}

class Choice {
  final String title;
  final IconData icon;
  final String backgroundImage;
  final String noData;
  final Future<List<User>> function;


  Choice({this.title, this.icon,this.backgroundImage,this.noData,this.function});
}

List<Choice> choices = <Choice>[
  Choice(title: "user", icon: Icons.upgrade, backgroundImage: "assets/images/achiement.svg",noData: "Upgrade as Admin", function: fetchUser("user")),
  Choice(title: "admin", icon: Icons.download_outlined, backgroundImage: "assets/images/board.svg",noData: "Downgrade as User",function: fetchUser("admin")),
];



Future<List<User>> fetchUser(role) async {
  List<User> users=[];
  var res = await Api().getData("user");
  var body = json.decode(res.body);
  if (res.statusCode == 200) {
    var count = 0;
    for (var u in body) {
      print(u);
      print(User.fromJson(u));

      User user = User.fromJson(u);
      print(user.role);
      if(user.role==role)
        users.add(user);
    }
    return users;
  } else {
    throw Exception('Failed to load album');
  }
}


Future<List<Admin>> fetchAdmin(role) async {
  List<Admin> admins=[];
  var res = await Api().getData("admin");
  var body = json.decode(res.body);
  if (res.statusCode == 200) {
    var count = 0;
    for (var u in body) {
      print(u);

      Admin admin = Admin.fromJson(u);
      print(admin.role);
      if(admin.role==role)
        admins.add(admin);
    }
    return admins;
  } else {
    throw Exception('Failed to load album');
  }
}
class ChoicePage extends StatefulWidget {

  const ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  List<User> users = [];
  var totalUser;
  var pr,data;
  var user;

  void getUserData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(localStorage.getString("user"));

    });  }
   @override
   void initState(){
     super.initState();
     getUserData();

     widget.choice.title=="admin" ? data=fetchAdmin(widget.choice.title) : data=fetchUser(widget.choice.title);
   }
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
    return Container(
      child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.3,
                decoration: BoxDecoration(color: kPrimaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Container(
                            height: size.height * 0.18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Image.asset("assets/images/bloodcell2.png"),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 9,
                                    spreadRadius: 7
                                )
                              ],
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceAround,
                            children: <Widget>[Container(
                              child: FlatButton(
                                child: Column(
                                  children: <Widget>[
                                    Text("Total User", style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width*0.033
                                    ),),
                                    Text(totalUser.toString(), style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width*0.033
                                    ))
                                  ],
                                ),
                                onPressed: () {

                                },
                              ),

                            ),

                              Container(
                                child: FlatButton(
                                  child: Column(
                                    children: <Widget>[
                                      Text("New User this week", style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width*0.033
                                      ),),
                                      Text("2", style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width*0.033
                                      ))
                                    ],
                                  ),
                                  onPressed: () {

                                  },
                                ),
                              ),
                              Container(
                                child: FlatButton(
                                  child: Column(
                                    children: <Widget>[
                                      Text("Total Admin", style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width*0.033
                                      ),),
                                      Text("1", style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width*0.033
                                      ))
                                    ],
                                  ),
                                  onPressed: () {

                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: size.height*0.7,
                  child: FutureBuilder(
                      future:data,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: LoadingScreen(),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 3,
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 9
                                        )
                                      ]
                                  ),
                                  height: size.height*0.6,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: FlatButton(
                                          color: Colors.white,
                                          child: Icon(Icons.add),
                                          onPressed: (){
                                              widget.choice.title=="admin" ?
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AddAdmin()),
                                              )
                                                  :
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AddUser()),
                                              );
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: size.height*0.5,

                                        child: ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context, int index){
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[

                                                    Container(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Container(
                                                                    height: size.height * 0.08,
                                                                    width: size.width * 0.18,
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                          fit: BoxFit.cover,
                                                                          image: NetworkImage(
                                                                            snapshot.data[index].imageURL,),
                                                                        ),
                                                                        borderRadius:
                                                                        BorderRadius.circular(2)),
                                                                  ),
                                                                  SizedBox(width: size.width*0.03,),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Text(
                                                                        snapshot.data[index].username,
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: 14),
                                                                      ),
                                                                      Text(
                                                                        snapshot.data[index].email,
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 13),
                                                                      ),

                                                                    ],
                                                                  ),

                                                                ],
                                                              ),
                                                            ), widget.choice.title=="admin" ? SizedBox() :
                                                        Text(
                                                              snapshot.data[index].bloodtype,
                                                              style:
                                                              TextStyle(color: kPrimaryColor),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        FlatButton(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.delete_forever,color: Colors.black,),
                                                              Text("Delete",style: TextStyle(
                                                                  color: Colors.black
                                                              ),)
                                                            ],
                                                          ),
                                                          onPressed: (){
                                                            _userDeleteDialog(snapshot.data[index].id);

                                                          },
                                                        ),
                                                        FlatButton(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.edit,color: Colors.black,),
                                                              Text("Edit",style: TextStyle(
                                                                  color: Colors.black
                                                              ))
                                                            ],
                                                          ),
                                                          onPressed: (){

                                                          },
                                                        ),
                                                       snapshot.data[index].id!=user["_id"] ? FlatButton(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(widget.choice.icon,color: Colors.black,),
                                                              Text(widget.choice.noData,style: TextStyle(
                                                                  color: Colors.black
                                                              ))
                                                            ],
                                                          ),
                                                          onPressed: (){
                                                            widget.choice.title=="admin" ? downgradeAsUser(snapshot.data[index].id) : upgradeAsAdmin(snapshot.data[index].id);

                                                            setState(() {
                                                              if(widget.choice.title=="admin"){
                                                                data=fetchAdmin(widget.choice.title);


                                                              }
                                                              else{
                                                                data = fetchUser(widget.choice.title);

                                                              }

                                                            });
                                                          },
                                                        ) : SizedBox()
                                                      ],
                                                    ),
                                                    SizedBox(height: size.height*0.04,)
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      }),
                ),
              ),

            ],
          )),
    );
  }


  Future<void> upgradeAsAdmin(id) async{

    var data = {
      "role": "admin"
    };
    var res = await Api().updateData(data, "user/${id}/role");
    if(res.statusCode==200){
      print("success");
    }
  }

  Future<void> downgradeAsUser(id) async{

    var data = {
      "role": "user"
    };
    var res = await Api().updateData(data, "user/${id}/role");
    if(res.statusCode==200){
      print("success");
    }
  }


  Future<bool> _userDeleteDialog(userId) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Delete User')),
          content: Text('Confirm to delete this user?'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); //Will not exit the App
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
                _deleteEvent(userId);
              },
            )
          ],
        );
      },
    ) ?? false;
  }

  _deleteEvent(userId) async{
    print(userId);
    var res = await Api().deleteData("user/${userId}");
    pr.show();
    if (res.statusCode == 200){
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => UserList()),
        );
        pr.hide();
      });

    }
  }

}



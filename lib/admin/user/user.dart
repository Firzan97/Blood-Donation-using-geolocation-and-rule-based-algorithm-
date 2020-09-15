import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [];
  var totalUser;

  @override
  void init() {
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
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("EASY BLOOD")),
          elevation: 0,
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Container(
                    height: size.height * 0.3,
                    decoration: BoxDecoration(color: kPrimaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: size.height * 0.18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Image.asset("assets/images/doctor.png"),
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
                                            color: Colors.black
                                        ),),
                                        Text(totalUser.toString())
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
                                          Text("New User this week",
                                            style: TextStyle(
                                                color: Colors.black
                                            ),),
                                          Text("2")
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
                                              color: Colors.black
                                          ),),
                                          Text("1")
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
              Container(
                height: size.height*0.7,
                child: FutureBuilder(
                    future: fetchUser(),
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
                          children: <Widget>[
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
                              child: ListView.builder(
                            itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index){
                                 return Column(
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
                                             ),
                                             Text(
                                               snapshot.data[index].bloodtype,
                                               style:
                                               TextStyle(color: kPrimaryColor),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ],
                                 );
                                })),
                          ],
                        ),
                      );
                    }),
              ),
            ])),
          ),
        ));
  }

  Future<List<User>> fetchUser() async {
    var res = await Api().getData("user");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      var count = 0;
      for (var u in body) {
        User user = User.fromJson(u);
        users.add(user);
      }

      return users;
    } else {
      throw Exception('Failed to load album');
    }
  }


}

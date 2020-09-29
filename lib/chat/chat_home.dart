import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/chat/chat_detail.dart';
import 'package:easy_blood/constant/data.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/message_screen.dart';
import 'package:easy_blood/model/conversation.dart';
import 'package:easy_blood/model/message.dart';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  TextEditingController _searchController = new TextEditingController();
  var currentUser;
  List<User> users=[];
  List<Message> latestMessages=[];

  var _futureConversation;

  _getUserData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      currentUser = jsonDecode(localStorage.getString("user"));
    });
  }


  @override
  void initState(){
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ),
    child: Scaffold(
      body: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: currentUser!=null ? NetworkImage(
                                  currentUser['imageURL']) : NetworkImage("https://easy-blood.s3-ap-southeast-1.amazonaws.com/loadProfileImage.png"),
                              fit: BoxFit.cover)),
                    ),
                    Text(
                      "Chats",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.edit)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    cursorColor: black,
                    controller: _searchController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          LineIcons.search,
                          color: black.withOpacity(0.5),
                        ),
                        hintText: "Search",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: fetchConversation(),
                          builder: (context,
                              snapshot) {
                            if (snapshot
                                .data ==
                                null) {
                              return Container(
                                height: size.height*0.4,
                                child:
                                Center(
                                  child:
                                  LoadingScreen(),
                                ),
                              );
                            }
                            return Container(
                              height:
                              size.height *
                                  0.4,
                              child: ListView
                                  .builder(
                                  itemCount: snapshot
                                      .data
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => MessageScreen(user: users[index])));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 75,
                                              height: 75,
                                              child: Stack(
                                                children: <Widget>[
                                                  userMessages[index]['story']
                                                      ? Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: blue_story, width: 3)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(3.0),
                                                      child: Container(
                                                        width: 75,
                                                        height: 75,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    users[index].imageURL),
                                                                fit: BoxFit.cover)),
                                                      ),
                                                    ),
                                                  )
                                                      : Container(
                                                    width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image:
                                                            NetworkImage(users[index].imageURL),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  userMessages[index]['online']
                                                      ? Positioned(
                                                    top: 48,
                                                    left: 52,
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                          color: online,
                                                          shape: BoxShape.circle,
                                                          border:
                                                          Border.all(color: white, width: 3)),
                                                    ),
                                                  )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  users[index].username,
                                                  style: TextStyle(
                                                      fontSize: 17, fontWeight: FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width - 135,
                                                  child: Text(

                                                    "${latestMessages.length!=0 ? latestMessages[index].message: ""}",
                                                    style: TextStyle(
                                                        fontSize: 15, color: black.withOpacity(0.8)
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
      ),
    ),);
  }

  Future<List<Conversation>> fetchConversation() async {
    var res = await Api().getData("conversation/${currentUser['_id']}");
    var body = json.decode(res.body);
    List<Conversation> convers = [];
    List<Message> messages = [];
    Conversation conver;
    User temp;
    if (res.statusCode == 200) {

      var count = 0;
      for (var u in body) {
        conver = Conversation.fromJson(u);

        if(conver.userReceive.id==currentUser['_id']){
          temp = conver.userSend;
        }
        else{
          temp = conver.userReceive;
        }
        users.add(temp);
        convers.add(conver);

        var temp2 = await Api().getData("latestMessage/${conver.id}");
        var temp3;


        if (temp2.statusCode == 200) {
          if(temp2.body.length!=0) {
            temp3 = json.decode(temp2.body);
            Message temp = Message.fromJson(temp3);
            print(temp.message);
            latestMessages.add(temp);
          }
          else{
           Message temp = new Message("","","");
           latestMessages.add(temp);
          }

          print("latestMessage/${conver.id}");

        }
      }
      return convers;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

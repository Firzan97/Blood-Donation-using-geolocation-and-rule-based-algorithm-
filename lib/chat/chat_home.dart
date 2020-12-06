import 'dart:async';
import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/chat/chat_detail.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/constant/data.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/chat/message_screen.dart';
import 'package:easy_blood/model/conversation.dart';
import 'package:easy_blood/model/message.dart';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  TextEditingController _searchController = new TextEditingController();
  var currentUser;
  List<User> users=[];
  List<User> users2=[];

  List<Message> latestMessages=[];
  List<Message> latestMessages2=[];

  List<String> unread=[];
  List<String> unread2=[];

  var futureConversation;
  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;
  Channel channel;
  String channelName = 'easy-blood';
  String eventName = "message";
  List<Conversation> convers = [];
  List<Conversation> convers2 = [];

  _getUserData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      currentUser = jsonDecode(localStorage.getString("user"));
    });
  }


  @override
  void initState(){
    super.initState();
//    initPusher();
    _getUserData();
    Future.delayed(const Duration(milliseconds: 500), () {

// Here you can write your code

      setState(() {
        futureConversation= fetchConversation();

      });

    });

  }
  Future<void> disposePusher()async{
    await channel.unbind(eventName);
    await Pusher.unsubscribe(channelName);
    Pusher.disconnect();

  }
  @override
  void dispose()
  {
    disposePusher();
    super.dispose();



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
        decoration: BoxDecoration(
          gradient: colorgradient,
            image: new DecorationImage(
        image: new AssetImage("assets/images/bloodcell.png"),
        fit: BoxFit.fill,
      )
        ),

          child: Padding(
            padding: const EdgeInsets.only( top: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:17.0),
                  child: Row(
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
                ),
                SizedBox(
                  height: size.height*0.12,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                        boxShadow: [
                    BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                      blurRadius: 5,
                      spreadRadius: 3
                  )
                    ]
                    ),
                    child: Column(
                      children: [
                        FutureBuilder(
                            future: futureConversation,
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
                              else if (snapshot
                                  .data.isEmpty) {
                                return Container(
                                  width: size.width*1,
                                  height: size.height*0.7,
                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("There are no message yet!"),
                                      SvgPicture.asset(
                                        "assets/images/message.svg",
                                        semanticsLabel: 'A red up arrow',height: 250,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return SingleChildScrollView(
                                child: Container(
                                  height:
                                  size.height *
                                      0.75,
                                  decoration: BoxDecoration(
                                  ),
                                  child: ListView
                                      .builder(
                                      itemCount: snapshot
                                          .data
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => MessageScreen(user: users[index], conversation: convers[index])));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border(

                                                bottom: BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.1)),
                                              ),

                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                                                  child: Container(
                                                    height: size.height*0.1,
                                                    child: Stack(
                                                      children: <Widget>[
//                                                  userMessages[index]['story']
//                                                      ? Container(
//                                                    decoration: BoxDecoration(
//                                                        shape: BoxShape.circle,
//                                                        border: Border.all(
//                                                            color: blue_story, width: 3)),
//                                                    child: Padding(
//                                                      padding: const EdgeInsets.all(3.0),
//                                                      child: Container(
//                                                        width: 75,
//                                                        height: 75,
//                                                        decoration: BoxDecoration(
//                                                            shape: BoxShape.circle,
//                                                            image: DecorationImage(
//                                                                image: NetworkImage(
//                                                                    users[index].imageURL),
//                                                                fit: BoxFit.cover)),
//                                                      ),
//                                                    ),
//                                                  )
//                                                      :
                                                    Container(
                                                      width: size.width*0.15,
                                                      height: size.height*0.09,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              image: DecorationImage(
                                                                  image:
                                                                  NetworkImage(users2[index].imageURL),
                                                                  fit: BoxFit.cover)),
                                                        ),

//                                                  userMessages[index]['online']
//                                                      ? Positioned(
//                                                    top: 48,
//                                                    left: 52,
//                                                    child: Container(
//                                                      width: 20,
//                                                      height: 20,
//                                                      decoration: BoxDecoration(
//                                                          color: online,
//                                                          shape: BoxShape.circle,
//                                                          border:
//                                                          Border.all(color: white, width: 3)),
//                                                    ),
//                                                  )
//                                                      : Container()
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: size.width*0.01,
                                                ),
                                                Container(
                                                  width: size.width*0.6,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        users2[index].username,
                                                        style: TextStyle(
                                                            fontSize: 17, fontWeight: FontWeight.w600),
                                                      ),
                                                      SizedBox(
                                                        height: size.height*0.001,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(context).size.width - 135,
                                                        child: Text(

                                                          "${latestMessages2.length!=0 ? latestMessages2[index].message: ""}",
                                                          style: TextStyle(
                                                              fontSize: 15, color: black.withOpacity(0.5)
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                unread2[index]=="0" ? Container() :
                                                Container(
                                                  width: size.width*0.08,

                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,

                                                      color: kGradient1.withOpacity(0.5),
                                                  ),
                                                  child: Center(
                                                    child: Text(unread2[index] ,style: TextStyle(
                                                      fontSize: size.width*0.039
                                                    ),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    ),);

  }

  Future<void> initPusher() async {
    var b,lastConnectionState;
    await Pusher.init(
        DotEnv().env['PUSHER_APP_KEY'],
        PusherOptions(cluster: DotEnv().env['PUSHER_APP_CLUSTER']),
        enableLogging: true
    );
    Pusher.connect(onConnectionStateChange: (x) async {
      if (mounted)
        setState(() {
          lastConnectionState = x.currentState;
        });
    }, onError: (x) {
      debugPrint("Error: ${x.message}");
    });

    channel = await Pusher.subscribe(channelName);


    await channel.bind(eventName, (x) {
      if (mounted)
        setState(() {
          b = x;
          print("babi");
        });
    });

  }

  Future<List<Conversation>> fetchConversation() async {
    setState(() {
      latestMessages= [];
      convers =[];
      unread=[];
      users=[];
    });
    var res = await Api().getData("conversation/${currentUser['_id']}");
    var body = json.decode(res.body);
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
        setState(() {
          users.add(temp);
          convers.add(conver);
        });

        var count = await Api().getData("message/${temp.id}/unread/${conver.id}");
        unread.add(count.body.toString());
        var temp2 = await Api().getData("latestMessage/${conver.id}");
        var temp3;

        if (temp2.statusCode == 200) {
          if(temp2.body.length!=0) {

            temp3 = json.decode(temp2.body);
            Message temp = Message.fromJson(temp3);
            latestMessages.add(temp);
            print("hail to the king");
            print(temp2.body);
          }
          else{
           Message temp = new Message("","","");
           latestMessages.add(temp);
          }
        }
      }
      setState(() {
        latestMessages2 = latestMessages;
        convers2 =convers;
        unread2=unread;
        users2=users;
      });
      print(convers.length);

      return convers2;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

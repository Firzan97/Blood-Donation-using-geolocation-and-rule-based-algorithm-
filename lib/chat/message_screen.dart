import 'dart:async';
import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/chat/chat_home.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/conversation.dart';
import 'package:easy_blood/model/message.dart';
import 'package:easy_blood/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_blood/theme/colors.dart';

import 'package:line_icons/line_icons.dart';

class MessageScreen extends StatefulWidget {
  final User user;
  final Conversation conversation;

  const MessageScreen({Key key, this.user, this.conversation}) : super(key: key);





  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController k = new TextEditingController();
  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;
  Channel channel;
  ScrollController _scrollController = new ScrollController();
  String channelName = 'easy-blood';
  String eventName = "message";
  var userId;
  var _futureMessage;
  List<String> messages = new List<String>();
  var bottomList=0;

  @override
  void dispose()
  {
    Pusher.unsubscribe(channelName);
    channel.unbind(eventName);
    _eventData.close();

    super.dispose();
  }

  _getUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
     setState(() {
       userId= jsonDecode(localStorage.getString("user"));
     });
  }
  @override
  void initState()
  {
    super.initState();
    _getUserData();

    initPusher();
    _readMessage();
      _futureMessage = fetchMessage();


  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatHome()),
        );
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor.withOpacity(0.6),
            elevation: 0,
            leading: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            title: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.user.imageURL),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.user.username,
                      style: TextStyle(
                          fontSize: size.width*0.040, fontWeight: FontWeight.bold, color: black),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Active now",
                      style: TextStyle(color: Colors.white, fontSize: size.width*0.026),
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[

              Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                    color: online,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white38)),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
            body: Column(
              children: [
                Container(
                  height: size.height*0.84,
                  child: FutureBuilder(
                    future: fetchMessage(),
                    builder: (context,snapshot){
                      return snapshot.data==null ? LoadingScreen()  :
                      ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 80),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext c, index){
                            return snapshot.data.length!=0 ? ChatBubble(isMe: snapshot.data[index].userSendId== userId['_id'] ? true : false,message: snapshot.data[index].message,profileImg: widget.user.imageURL) : Container();
                          }
                      );
                    },
                  ),
                ),
              ],
            ),
        bottomSheet: Container(
          height: size.height*0.1,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: colorgradient,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Row(

                    children: <Widget>[
                      Container(
                        width: size.width*0.75,
                        height: size.height*0.07,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 9,
                              spreadRadius: 4
                            )
                          ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: TextField(
                          cursorColor: black,
                          controller: k,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 12),

                            border: InputBorder.none,
                              hintText: "Write a reply ....",
                            hintStyle: TextStyle(
                              fontSize: size.width*0.042
                            )
                          ),
                        ),
                      ),

                      IconButton(icon: Icon(Icons.send,size: size.width*0.08,color: Colors.black),onPressed: (){
//                      _sendMessage(k.text);
                        _setConversation();

                      },),
                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Message>> fetchMessage() async {
    print("babiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii ${userId}");
    var res = await Api().getData("conversationMessage/${widget.user.id}/${userId['_id']}");

    if (res.statusCode == 200) {
      List<Message> messages = [];
      var count=0;
      if(res.body.length!=0){
        var body = json.decode(res.body);
        for (var u in body) {
          count++;
          Message event = Message.fromJson(u);
          messages.add(event);
        }

      WidgetsBinding.instance
          .addPostFrameCallback((_){
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
      }



      return messages;
    } else {
      throw Exception('Failed to load album');
    }
  }

  _setConversation() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var user= jsonDecode(userjson);

    var data = {
      "userSendId": user["_id"],
      "userReceiveId": widget.user.id,
      "isRead": false,
      "message": k.text
    };

    var res = await Api().postData(data,"conversation");

    if(res.statusCode==200){
      print("menjadi babi");
      setState(() {
        k.text="";
      });
    }
  }

  _readMessage() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var user= jsonDecode(userjson);

    var data = {
      "userId": widget.user.id,
      "isRead": true,
    };

    var res = await Api().updateData(data,"message/${widget.conversation.id}");

    if(res.statusCode==200){
      print("menjadi babi update isread ${widget.user.id} message/${widget.conversation.id}");
    }
  }


//  Future _sendMessage(message) async{
//    var data = {
//      'message': message
//    };
//
//    var res = await Api().postData(data,"message");
//
//  }

  Future<void> initPusher() async {
    await Pusher.init(
        DotEnv().env['PUSHER_APP_KEY'],
        PusherOptions(cluster: DotEnv().env['PUSHER_APP_CLUSTER']),
        enableLogging: true
    );

    Pusher.connect();

    channel = await Pusher.subscribe(channelName);

    channel.bind(eventName, (last) {
      final String data = last.data;
      _inEventData.add(data);
    });

    eventStream.listen((data) async {
      setState(() {
        _futureMessage= fetchMessage();
        WidgetsBinding.instance
            .addPostFrameCallback((_){
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
        });
      });
    });
  }
}

class ChatBubble extends StatefulWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final int messageType;
  const ChatBubble({
    Key key, this.isMe, this.profileImg, this.message, this.messageType,
  }) : super(key: key);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(widget.isMe){
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 15.0),

                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    gradient: colorgradient,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                        color: white,
                        fontSize: size.width*0.033
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }else{
      return Padding(
        padding:  EdgeInsets.all(1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.profileImg),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 15.0),
                decoration: BoxDecoration(
                    gradient: colorgradient3,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(5),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                        color: black,
                        fontSize: size.width*0.033
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
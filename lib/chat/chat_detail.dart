import 'dart:async';
import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/constant/data.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/message.dart';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatDetail extends StatefulWidget {
  final User user;

  const ChatDetail({Key key, this.user}) : super(key: key);
  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  TextEditingController _sendMessageController = new TextEditingController();
  var currentUser;
  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;
  Channel channel;
  ScrollController _scrollController = new ScrollController();
  String channelName = 'easy-blood';
  String eventName = "message";
  var futureMessage;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  _getUserData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      currentUser = jsonDecode(localStorage.getString("user"));
    });
  }

  @override
  void dispose()
  {
    Pusher.unsubscribe(channelName);
    channel.unbind(eventName);
    _eventData.close();

    super.dispose();
  }


  @override
  void initState(){
    super.initState();
    _getUserData();
    futureMessage=fetchMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: grey.withOpacity(0.2),
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: primary,
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
                      fontSize: 18, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Active now",
                  style: TextStyle(color: black.withOpacity(0.4), fontSize: 14),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          Icon(
            LineIcons.phone,
            color: primary,
            size: 32,
          ),
          SizedBox(
            width: 15,
          ),
          Icon(
            LineIcons.video_camera,
            color: primary,
            size: 35,
          ),
          SizedBox(
            width: 8,
          ),
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
      body: getBody(),
      bottomSheet: getBottom(),
    );


  }

  Future<List<Message>> fetchMessage() async {

    var res = await Api().getData("conversationMessage/${widget.user.id}");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Message> messages = [];
      var count=0;
      for (var u in body) {
        count++;
        Message event = Message.fromJson(u);
        messages.add(event);
      }

      WidgetsBinding.instance
          .addPostFrameCallback((_){
        if (_scrollController.hasClients) {
          print("bodo");
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
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
      "message": _sendMessageController.text
    };
    print("takkkk jadiiiiiiiiiii");

    var res = await Api().postData(data,"conversation");
    if(res.statusCode==200){
      print("menjadiii gila babsaisiasasasasasa");
    }
  }

  Future _sendMessage(message) async{
    var data = {
      'message': message
    };

    var res = await Api().postData(data,"message");

  }

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
        WidgetsBinding.instance
            .addPostFrameCallback((_){
          if (_scrollController.hasClients) {
            print("bodo");
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
        });
      });
    });
  }

  Widget getBottom(){
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: grey.withOpacity(0.2)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40)/2,
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_circle,size: 35,color: primary,),
                  SizedBox(width: 15,),
                  Icon(Icons.camera_alt,size: 35,color: primary,),
                  SizedBox(width: 15,),
                  Icon(Icons.photo,size: 35,color: primary,),
                  SizedBox(width: 15,),
                  Icon(Icons.keyboard_voice,size: 35,color: primary,),
                ],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width- 40)/2,
              child: Row(
                children: <Widget>[
                  Container(
                    width: (MediaQuery.of(context).size.width-140)/2,
                    height: 40,
                    decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: TextField(
                        cursorColor: black,
                        controller: _sendMessageController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Aa",
                            suffixIcon: Icon(Icons.face,color: primary,size: 35,)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 1,),
                  IconButton(icon: Icon(Icons.send,size: 35,color: primary),onPressed: (){
                    _sendMessage(_sendMessageController.text);
                    _setConversation();
                    setState(() {
                      futureMessage =  fetchMessage();

                    });
                  },),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }

  Widget getBody() {

    return FutureBuilder(
      future: futureMessage,
      builder: (context,snapshot){
        return snapshot.data==null ? LoadingScreen() :
        ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 80),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext c, index){
            return ChatBubble(isMe: snapshot.data[index].userSendId== currentUser['_id'] ? true : false,messageType: messages[index]['messageType'],message: snapshot.data[index].message,profileImg: widget.user.imageURL);
          }
        );
      },
    );
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
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                        color: white,
                        fontSize: 17
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
                    color: kGradient1,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                        color: black,
                        fontSize: 17
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

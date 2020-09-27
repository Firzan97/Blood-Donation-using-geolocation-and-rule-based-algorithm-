import 'dart:async';
import 'dart:convert';

import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/event/bloodEvent.dart';
import 'package:easy_blood/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageScreen extends StatefulWidget {
  final String receivedID;

  const MessageScreen({Key key, this.receivedID}) : super(key: key);





  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController k = new TextEditingController();
  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;

  Channel channel;

  String channelName = 'easy-blood';
  String eventName = "message";
  var userjson;
  var user;
  List<String> messages = new List<String>();

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
     userjson = localStorage.getString("user");
     user= jsonDecode(userjson);
  }
  @override
  void initState()
  {
    super.initState();

    initPusher();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Laravel + Pusher',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Messages'),
            leading: IconButton(onPressed: (){
              setState(() {
                Pusher.unsubscribe(channelName);
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BloodEvent()),
              );
            },icon: Icon(Icons.arrow_back),),
          ),
          body: Column(
            children: [
              Container(
                height: 600,
                child: FutureBuilder(
                  future: fetchMessage(),
                    builder: (context, snapshot) {
                      return
                      ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.all(15),
                              child: Column(
                                 crossAxisAlignment: snapshot.data[index].userSendId== user['_id'] ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
                                children: [
//                                    Text(
//                                      messages[index],
//                                      style: TextStyle(
//                                        fontSize: 20,
//                                        fontWeight: FontWeight.bold,
//                                      ),
//                                    ),
                                  Text(
                                    snapshot.data[index].message,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }
                      );
                    }
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      controller: k,

                    ),
                  ),
                  FlatButton(
                    child: Container(
                      child: Icon(Icons.pin_drop),
                    ),
                    onPressed: (){
//                      _sendMessage(k.text);
                      _setConversation();
                    },
                  )
                ],
              ),
            ],
          )
      ),
    );
  }

  Future<List<Message>> fetchMessage() async {

    var res = await Api().getData("message");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Message> messages = [];
      var count=0;
      for (var u in body) {
        count++;
        Message message = Message.fromJson(u);
        messages.add(message);
        print("halliiiiiiiuuuu");
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
      "userReceiveId": widget.receivedID,
      "message": k.text
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
      Map<String, dynamic> message = jsonDecode(data);

      setState(() {
        messages.add(message['message']);
      });
    });
  }
}
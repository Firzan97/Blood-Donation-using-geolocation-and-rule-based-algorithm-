import 'package:easy_blood/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_blood/model/request.dart';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/api/api.dart';
import 'dart:convert';
import 'dart:async';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/component/curvedBackground.dart';


class Achievement extends StatefulWidget {
  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded,color: Colors.white,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            shadowColor: kPrimaryColor,
            backgroundColor: kPrimaryColor,
            title: Text("Achievement"),
            centerTitle: true,

            bottom: TabBar(
              indicatorColor: Colors.black,

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
      ),

    );
  }


}

class Choice {
  final String title;
  final Icon icon;
  final String backgroundImage;
  final String noData;

  Choice({this.title, this.icon,this.backgroundImage,this.noData});
}

List<Choice> choices = <Choice>[
  Choice(title: "Trophy", icon: Icon(FontAwesomeIcons.trophy), backgroundImage: "assets/images/achiement.svg",noData: "No Achievement Yet!"),
  Choice(title: "Leaderboard", icon: Icon(FontAwesomeIcons.trophy), backgroundImage: "assets/images/board.svg",noData: "Cannot generate leaderboard if you do not have any achievement yet!"),
];

class ChoicePage extends StatefulWidget {

  const ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  Color selected1,selected2,selected3;
  int trophies = 0;
  List<User> a=[];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.choice.title=="Trophy" ?
    Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width*1,
          height: size.height*1,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.0,),
                Container(
                  height: size.height*0.17,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 10
                        )
                      ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://image.cnbcfm.com/api/v1/image/104819285-thor.jpg?v=1529476684')
                                ))
                ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text("Hairul Najmi"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("Blood Donated : "),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(

                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Text("Total Trophies : ${trophies.toString()}"),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0,),

              Container(
                  height: size.height*0.5 ,
                  width: size.width*1,
                  child: FutureBuilder(
                    future: fetchBlood(),
    builder: (BuildContext context,AsyncSnapshot snapshot){
      if(!snapshot.hasData){
        return Container(
          height:size.height*0.27,
          child: Center(
            child: LoadingScreen(),
          ),
        );
      }
                       if(snapshot.hasData){
                         if(snapshot.data.length==0){
                           return  Column(
                             children: [
                               Text(widget.choice.noData,    textAlign: TextAlign.center,
                               ),
                               SizedBox(height: 30.0,),
                               Padding(
                                 padding: const EdgeInsets.all(20.0),
                                 child: SvgPicture.asset(
                                   widget.choice.backgroundImage,
                                   semanticsLabel: 'A red up arrow',height: 200,
                                 ),
                               )
                             ],
                           );

                         }
                        return GridView.count(
                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this produces 2 rows.
                          crossAxisCount: 3,
                          // Generate 100 widgets that display their index in the List.
                          children: List.generate(snapshot.data.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'https://image.cnbcfm.com/api/v1/image/104819285-thor.jpg?v=1529476684')
                                      ))
                              ),
                            );
                          }),
                        );
                      }



    }

                  ),
                )
//              SizedBox(height: 70.0,),
//              Text(widget.choice.noData,    textAlign: TextAlign.center,
//                  ),
//              SizedBox(height: 30.0,),
//              Padding(
//                padding: const EdgeInsets.all(20.0),
//                child: SvgPicture.asset(
//                  widget.choice.backgroundImage,
//                  semanticsLabel: 'A red up arrow',height: 200,
//                ),
//              ),
              ],
            ),
          ),
        ),
      ),
    ) :
    Column(
      children: [
        Container(
          height: size.height*0.32,
          width: size.width*1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(40))
          ),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width*1,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width*0.64,
                          height: size.height*0.04,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 8
                                )
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected1 = Colors.white;
                                    selected2 = Colors.red;
                                    selected3 = Colors.red;
                                  });
                                },
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      color: selected1,
                                      borderRadius: BorderRadius.circular(20)

                                  ),
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("All The Time"),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected1 = Colors.red;
                                    selected2 = Colors.white;
                                    selected3 = Colors.red;
                                  });
                                },
                                child: Container(
                                  height: double.infinity,

                                  decoration: BoxDecoration(
                                      color: selected2,
                                      borderRadius: BorderRadius.circular(20)

                                  ),
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Last Week"),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected1 = Colors.red;
                                    selected2 = Colors.red;
                                    selected3 = Colors.white;
                                  });
                                },
                                child: Container(
                                  height: double.infinity,

                                  decoration: BoxDecoration(
                                      color: selected3,
                                      borderRadius: BorderRadius.circular(20)

                                  ),
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Last Month"),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height*0.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [

                            Container(
                              width: size.width*0.24,
                                height: size.height*0.17,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 4,
                                          blurRadius: 10
                                      )
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://image.cnbcfm.com/api/v1/image/104819285-thor.jpg?v=1529476684')
                                    ))
                            ),
                            Positioned(
                              left: size.width*0.07,
                              child: Container(
                                height: size.height*0.05,
                                width: size.width*0.1,
                                child: Center(child: Text("2",style: TextStyle(
                                    fontSize: size.height*0.025,
                                    fontFamily: "Muli"
                                ),)),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20)

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("9 Times",style: TextStyle(
                                fontSize: size.height*0.016,
                                fontFamily: "Muli"
                            )),
                          ),
                        )
                      ],
                    ),
                    Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(
                            height: size.height*0.20,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                                  child: Container(
                                      width: size.width*0.4,
                                      height: size.height*0.17,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 4,
                                                blurRadius: 10
                                            )
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  'https://image.cnbcfm.com/api/v1/image/104819285-thor.jpg?v=1529476684')
                                          ))
                                  ),
                                ),
                                Positioned(
                                    bottom: size.height*0.14,
                                    left: size.width*0.12,
                                    child: Image.asset("assets/images/king.png",scale: 7,)),

                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(20)

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("10 Times",style: TextStyle(
                                  fontSize: size.height*0.016,
                                  fontFamily: "Muli"
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Stack(
                          children: [
                            Container(
                                width: size.width*0.22,
                                height: size.height*0.17,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 4,
                                          blurRadius: 10
                                      )
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://image.cnbcfm.com/api/v1/image/104819285-thor.jpg?v=1529476684')
                                    ))
                            ),
                            Positioned(
                              right: size.width*0.06,
                              child: Container(
                                height: size.height*0.04,
                                width: size.width*0.1,
                                child: Center(child: Text("3",style: TextStyle(
                                    fontSize: size.height*0.025,
                                    fontFamily: "Muli"
                                ),)),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("8 Times",style: TextStyle(
                                fontSize: size.height*0.016,
                                fontFamily: "Muli"
                            )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
        Expanded(
          child: Container(
            width: size.width*1,
            child: FutureBuilder(
              future: fetchBlood(),
    builder: (BuildContext context,AsyncSnapshot snapshot){
                if(!snapshot.hasData){
                  return Container(
                    height:size.height*0.27,
                    child: Center(
                      child: LoadingScreen(),
                    ),
                  );
                }
                if(snapshot.hasData){
                  if(snapshot.data.length==0){
                    return Column(
                      children: [
                        Text(widget.choice.noData,    textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.0,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SvgPicture.asset(
                            widget.choice.backgroundImage,
                            semanticsLabel: 'A red up arrow',height: 200,
                          ),
                        ),
                      ],
                    );
                  }
                  return SingleChildScrollView(
                    child: Container(
                  height: size.height*1,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                      ),
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                        return  Padding(
                          padding: const EdgeInsets.only(top: 16.0,left: 8.0,right: 8.0),
                          child: Container(
                            height: size.height*0.1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 8,
                                      spreadRadius: 9
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text((index+4).toString(),style: TextStyle(
                                    fontFamily: "Muli",
                                    fontSize: size.height*0.025
                                  ),),
                                ),
                                Container(
                                    width: size.width*0.22,
                                    height: size.height*0.17,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              spreadRadius: 4,
                                              blurRadius: 10
                                          )
                                        ],
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'https://image.cnbcfm.com/api/v1/image/104819285-thor.jpg?v=1529476684')
                                        ))
                                ),
                                SizedBox(width: size.width*0.02,),
                                Text(snapshot.data[index].user.username),
                                SizedBox(width: size.width*0.4,),
                                Text(" 5 times")
                              ],
                            ),
                          ),
                        );
                      }
                ,
                    )),
                  );}
    }
            ),
          ),
        ),


      ],
    );
  }

  Future<List<Requestor>> fetchBlood() async {
    var res = await Api().getData("request");
    var bodys = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Requestor> requests = [];
      for (Map u in bodys) {
        Requestor req = Requestor.fromJson(u);
        User user = req.user;
        a.add(user);
        requests.add(req);
      }
setState(() {
  trophies= requests.length;
});
      return requests;
    } else {
      throw Exception('Failed to load album');
    }
  }
}


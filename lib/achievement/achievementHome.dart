import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_blood/animation/faceAnimation.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/model/userAchievement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_blood/model/request.dart';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/model/leaderboard.dart';

import 'package:easy_blood/api/api.dart';
import 'dart:convert';
import 'dart:async';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/component/curvedBackground.dart';
import "package:easy_blood/model/achievement.dart";
import 'package:shared_preferences/shared_preferences.dart';

class AchievementPage extends StatefulWidget {
  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
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
                tabs: choices.map<Widget>((Choice choice) {
                  return Tab(
                    text: choice.title,
                  );
                }).toList(),
              ),
            ),
            body: TabBarView(
                children: choices.map((Choice choice) {
              return ChoicePage(
                choice: choice,
              );
            }).toList())),
      ),
    );
  }
}

class Choice {
  final String title;
  final Icon icon;
  final String backgroundImage;
  final String noData;

  Choice({this.title, this.icon, this.backgroundImage, this.noData});
}

List<Choice> choices = <Choice>[
  Choice(
      title: "Trophy",
      icon: Icon(FontAwesomeIcons.trophy),
      backgroundImage: "assets/images/achiement.svg",
      noData: "No Achievement Yet!"),
  Choice(
      title: "Leaderboard",
      icon: Icon(FontAwesomeIcons.trophy),
      backgroundImage: "assets/images/board.svg",
      noData:
          "Cannot generate leaderboard if you do not have any achievement yet!"),
];

class ChoicePage extends StatefulWidget {
  const ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  Color selected1, selected2, selected3;
  int trophies = 0;
  List<User> a = [];
  Future<List<Achievement>> _FutureFetchAchievement;
  Future<List<Leaderboard>>  _futureFetchLeaderBoard;
  int totalDonated = 0;
  List<Color> colors = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey
  ];
  List<String> description = [];
  List<String> type = [];
  var currentUser;
  String user_id;
  List<int> numberDonate = [1, 3, 10, 15, 30];
  List<Leaderboard> top3 = [];
  List<int> totalDonor=[];
  List<int> totalDonorTop3=[];
  @override
  void initState() {
    super.initState();
    getUserData();
    _futureFetchLeaderBoard= fetchLeaderBoard();
    _FutureFetchAchievement = fetchBlood();
    fetchBloodDonatedCount();
    achievementComparison();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.choice.title == "Trophy"
        ? Center(
            child: Container(
              width: size.width * 1,
              height: size.height * 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                          height: size.height * 0.17,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 4,
                                    blurRadius: 10)
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(currentUser != null
                                      ? currentUser["imageURL"]
                                      : "https://easy-blood.s3-ap-southeast-1.amazonaws.com/loadProfileImage.png")))),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                            currentUser != null ? currentUser["username"] : ""),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Blood Donated : ${totalDonated}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child:
                                Text("Total Trophies : ${trophies.toString()}"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      Container(
                        height: size.height * 0.37,
                        width: size.width * 1,
                        child: FutureBuilder(
                            future: _FutureFetchAchievement,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                  height: size.height * 0.27,
                                  child: Center(
                                    child: LoadingScreen(),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Column(
                                    children: [
                                      Text(
                                        widget.choice.noData,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: SvgPicture.asset(
                                          widget.choice.backgroundImage,
                                          semanticsLabel: 'A red up arrow',
                                          height: 200,
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
                                  children: List.generate(snapshot.data.length,
                                      (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: size.height * 0.1,
                                                    decoration: BoxDecoration(
                                                        color: colors[index],
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.9),
                                                              spreadRadius: 1,
                                                              blurRadius: 2)
                                                        ]),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Image.asset(
                                                        "${snapshot.data[index].imageURL}",
                                                        scale: 4,
                                                      ),
                                                    ),
                                                  ),
                                                  colors[index] == Colors.grey
                                                      ? Container(
                                                          height: size.height *
                                                              0.107,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.asset(
                                                            "assets/images/lock.png",
                                                            scale: 0.8,
                                                          ),
                                                        )
                                                      : SizedBox()
                                                ],
                                              ),
                                              onTap: () {
                                                AwesomeDialog(
                                                  context: context,
                                                  dismissOnBackKeyPress: true,
                                                  dialogType:
                                                      DialogType.NO_HEADER,
                                                  body: Center(
                                                    child: Column(
                                                      children: [
                                                        colors[index] ==
                                                                Colors.grey
                                                            ? SizedBox()
                                                            : Text(
                                                                "Congratulations!",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Muli",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        27),
                                                              ),
                                                        colors[index] ==
                                                                Colors.grey
                                                            ? SizedBox()
                                                            : FadeAnimation(
                                                                1.3,
                                                                Container(
                                                                  height:
                                                                      size.height *
                                                                          0.3,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/images/medal.png",
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                        colors[index] ==
                                                                Colors.grey
                                                            ? SizedBox()
                                                            : RichText(
                                                                text: TextSpan(
                                                                  text:
                                                                      'You earn ',
                                                                  style: DefaultTextStyle.of(
                                                                          context)
                                                                      .style,
                                                                  children: <
                                                                      TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            '${type[index]} ',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize: 22)),
                                                                    TextSpan(
                                                                        text:
                                                                            ' badge!'),
                                                                  ],
                                                                ),
                                                              ),
                                                        colors[index] ==
                                                                Colors.grey
                                                            ? Text(
                                                                '${type[index]} ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        22),
                                                              )
                                                            : Text(
                                                                " ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Muli",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        22),
                                                              ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.02,
                                                        ),
                                                        FadeAnimation(
                                                          1.1,
                                                          Container(
                                                            height:
                                                                size.height *
                                                                    0.25,
                                                            child: Stack(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        size.height *
                                                                            0.2,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                      child: Image
                                                                          .asset(
                                                                        "${snapshot.data[index].imageURL}",
                                                                        scale:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                colors[index] ==
                                                                        Colors
                                                                            .grey
                                                                    ? Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              size.height * 0.28,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/lock.png",
                                                                            scale:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox()
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          colors[index] ==
                                                                  Colors.grey
                                                              ? "You need to push harder to earn this achievement! ${numberDonate[index] - totalDonated} more donation to be done! "
                                                              : description[
                                                                  index],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  headerAnimationLoop: false,
                                                  animType: AnimType.SCALE,
                                                  title: type[index],
                                                  desc: description[index],
                                                )..show();
                                              },
                                            ),
                                          ),
                                          Text(snapshot.data[index].type)
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              }
                            }),
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
          )
        : Column(
            children: [
              Container(
                height: size.height * 0.35,
                width: size.width * 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40))),
                child: Column(
                  children: [
                   SizedBox(height: size.height*0.05,),
                    Container(
                      height: size.height * 0.25,
                      child: Row(

                        children: [
                          top3.length>=2 ? Container(
                            width: size.width/3,
                            height: size.height * 0.20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                        width: size.width * 0.24,
                                        height: size.height * 0.17,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 1,
                                                  blurRadius: 2)
                                            ],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    top3[1].imageURL
                                                )))),
                                    Positioned(
                                      left: size.width * 0.07,
                                      child: Container(
                                        height: size.height * 0.05,
                                        width: size.width * 0.1,
                                        child: Center(
                                            child: Text(
                                          "2",
                                          style: TextStyle(
                                              fontSize: size.height * 0.025,
                                              fontFamily: "Muli"),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.height*0.03,
                                  width: size.width*0.18,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text("${top3[1].count.toString()} donation",
                                        style: TextStyle(
                                            fontSize: size.height * 0.016,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Muli")),
                                  ),
                                )
                              ],
                            ),
                          ) : SizedBox(),
                          top3.length>=1 ? Container(
                            width: top3.length==1 ? size.width/1 : size.width/3,
                            height: size.height * 0.27,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: size.height * 0.20,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0),
                                        child: Container(
                                            width: size.width * 0.4,
                                            height: size.height * 0.17,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      spreadRadius: 2,
                                                      blurRadius: 1)
                                                ],
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:  NetworkImage(
                                                        top3[0].imageURL
                                                    )))),
                                      ),
                                      Positioned(
                                          bottom: size.height * 0.15,
                                          left: size.width * 0.08,
                                          child: Image.asset(
                                            "assets/images/king.png",
                                            scale: 7,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: size.height*0.03,
                                  width: size.width*0.18,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text("${top3[0].count.toString()} donation",
                                        style: TextStyle(
                                            fontSize: size.height * 0.016,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Muli")),
                                  ),
                                )
                              ],
                            ),
                          ) : SizedBox(),
                          top3.length>=3 ? Container(
                            width: size.width/3,
                            height: size.height * 0.20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                        width: size.width * 0.22,
                                        height: size.height * 0.17,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 4,
                                                  blurRadius: 10)
                                            ],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  top3[2].imageURL
                                                )))),
                                    Positioned(
                                      top: size.height*0.013,
                                      right: size.width * 0.06,
                                      child: Container(
                                        height: size.height * 0.04,
                                        width: size.width * 0.1,
                                        child: Center(
                                            child: Text(
                                          "3",
                                          style: TextStyle(
                                              fontSize: size.height * 0.025,
                                              fontFamily: "Muli"),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.height*0.03,
                                  width: size.width*0.18,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text("${top3[2].count.toString()} donation",
                                        style: TextStyle(
                                            fontSize: size.height * 0.016,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Muli")),
                                  ),
                                )
                              ],
                            ),
                          ) : SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 2,
                          spreadRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Container(
                      width: size.width * 1,
                      child: FutureBuilder(
                          future: _futureFetchLeaderBoard,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                height: size.height * 0.27,
                                child: Center(
                                  child: LoadingScreen(),
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              if (snapshot.data.length == 0) {
                                return Column(
                                  children: [
                                    top3.length==0 ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.choice.noData,
                                        textAlign: TextAlign.center,
                                      ),
                                    )  : SizedBox(),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: SvgPicture.asset(
                                        widget.choice.backgroundImage,
                                        semanticsLabel: 'A red up arrow',
                                        height: 200,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container(
                                  height: size.height * 0.44,
                                  child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0,
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 8.0),
                                        child: Container(
                                          height: size.height * 0.1,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    blurRadius: 8,
                                                    spreadRadius: 9)
                                              ]),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  (index + 4).toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Muli",
                                                      fontSize:
                                                          size.height * 0.025),
                                                ),
                                              ),
                                              Container(
                                                  width: size.width * 0.22,
                                                  height: size.height * 0.17,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 4,
                                                            blurRadius: 10)
                                                      ],
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              snapshot
                                                                  .data[index]
                                                                  .imageURL)))),
                                              SizedBox(
                                                width: size.width * 0.02,
                                              ),
                                              Container(
                                                  width: size.width * 0.3,
                                                  child: Text(snapshot
                                                      .data[index].username)),
                                              SizedBox(
                                                width: size.width * 0.17,
                                              ),
                                              Text(snapshot.data[index].count.toString()),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                            }
                          }),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Future<void> achievementComparison() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentUser = jsonDecode(pref.getString("user"));
      user_id = currentUser["_id"];
    });
    int count = 0;
    var data;
    var res = await Api().getData("userAchievement/${currentUser["_id"]}");
    var bodys = json.decode(res.body);
    if (res.statusCode == 200) {
      for (Map u in bodys) {
        print("babi");

        UserAchievement userAchievement = UserAchievement.fromJson(u);
        if (userAchievement.userId == currentUser["_id"]) {

          setState(() {
            colors[count] = Colors.red;
            trophies++;
          });
          count++;
        }
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentUser = jsonDecode(pref.getString("user"));
      user_id = currentUser["_id"];
    });
  }

  Future<void> fetchBloodDonatedCount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentUser = jsonDecode(pref.getString("user"));
      user_id = currentUser["_id"];
    });
    var res = await Api().getData("user/${currentUser["_id"]}/totalRequest");
    var bodys = json.decode(res.body);
    if (res.statusCode == 200) {
          setState(() {
            totalDonated=bodys;
          });
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Achievement>> fetchBlood() async {
    var res = await Api().getData("achievement");
    var bodys = json.decode(res.body);
    int count = 0;
    if (res.statusCode == 200) {
      List<Achievement> achievements = [];
      for (Map u in bodys) {
        Achievement achievement = Achievement.fromJson(u);
          achievements.add(achievement);
          setState(() {
            description.add(achievement.description);
            type.add(achievement.type);
          });
        count++;
      }

      return achievements;
    } else {
      throw Exception('Failed to load album');
    }
  }


  Future<List<Leaderboard>> fetchLeaderBoard() async {
    top3 = [];
    var res = await Api().getData("leaderBoard");
    var bodys = json.decode(res.body);
    int count = 0;
    int count1=0;
    int count2=0;
    Requestor req;

    if (res.statusCode == 200) {
      List<Leaderboard> leaderboards = [];
      for (Map u in bodys) {
          Leaderboard leaderboard = Leaderboard.fromJson(u);
          if(count<3){
            setState(() {
              top3.add(leaderboard);

            });
          }
          else{
            setState(() {
              leaderboards.add(leaderboard);
            });
          }
          count++;
      }

      return leaderboards;
    } else {
      throw Exception('Failed to load album');
    }
  }

}

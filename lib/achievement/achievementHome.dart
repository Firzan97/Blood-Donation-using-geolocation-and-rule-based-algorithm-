import 'package:easy_blood/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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


class ChoicePage extends StatelessWidget {

  const ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width*1,
          height: size.height*1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70.0,),
              Text(choice.noData,    textAlign: TextAlign.center,
                  ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  choice.backgroundImage,
                  semanticsLabel: 'A red up arrow',height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


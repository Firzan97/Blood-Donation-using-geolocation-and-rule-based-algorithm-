
import 'package:flutter/material.dart';
import 'package:easy_blood/model/user.dart';
class Choice {
  final String title;
  final IconData icon;
  final String backgroundImage;
  final String noData;
  final Future<List<User>> function;


  Choice({this.title, this.icon,this.backgroundImage,this.noData,this.function});
}
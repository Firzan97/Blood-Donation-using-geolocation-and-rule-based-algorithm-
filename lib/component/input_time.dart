import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class InputTime extends StatelessWidget {
  final String name;
  const InputTime({Key key, this.name}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
      child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {

            DatePicker.showTime12hPicker(context,
                theme: DatePickerTheme(
                    headerColor: kGradient1,
                    backgroundColor: Colors.white,
                    itemStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
                showTitleActions: true, onChanged: (date) {
              print('change $date in time zone ' +
                  date.timeZoneOffset.inHours.toString());
            }, onConfirm: (date) {
              print('confirm $date');
            }, currentTime: DateTime.now());
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.timer),
              Text(
                "Time ${name}",
                style: TextStyle(color: Colors.black),
              ),
            ],
          )),
    );
  }
}

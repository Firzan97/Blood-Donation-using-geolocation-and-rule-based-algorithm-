import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class InputTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          DatePicker.showTime12hPicker(context,
              theme: DatePickerTheme(
                  headerColor: kPrimaryColor,
                  backgroundColor: kThirdColor,
                  itemStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
              showTitleActions: true, onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            print('confirm $date');
          }, currentTime: DateTime.now());
        },
        child: Text(
          'Time',
          style: TextStyle(color: Colors.blue),
        ));
  }
}

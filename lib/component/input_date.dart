import 'package:easy_blood/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class InputDate extends StatefulWidget {
  final String name;

  const InputDate({Key key1, this.name}) : super(key: key1);

  @override
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
          onPressed: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(2020, 3, 5),
                maxTime: DateTime(2029, 6, 7),
                theme: DatePickerTheme(
                    headerColor: kPrimaryColor,
                    backgroundColor: kThirdColor,
                    itemStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                onChanged: (date) {
              print('change $date in time zone ' +
                  date.timeZoneOffset.inHours.toString());
            }, onConfirm: (date) {
              print('confirm ${date}');
            }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.date_range),
              Text(
                '${widget.name} Date',
                style: TextStyle(color: Colors.black),
              ),
            ],
          )),
    );
  }
}

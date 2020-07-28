import 'package:easy_blood/component/input_container.dart';
import 'package:easy_blood/constant.dart';
import "package:flutter/material.dart";

class InputRound extends StatelessWidget {
  final IconData icon;
  final ValueChanged<String> onchanged;
  final ValueChanged<String> validator;
  final InputDecoration deco;
  final TextEditingController controller;

  const InputRound({
    Key key,
    this.icon,
    this.onchanged,
    this.validator,
    this.deco,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        controller: controller,
        cursorColor: kPrimaryColor,
        onChanged: onchanged,
        validator: validator,
        decoration: deco,

      ),
    );
  }
}

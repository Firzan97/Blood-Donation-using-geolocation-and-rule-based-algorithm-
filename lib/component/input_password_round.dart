import 'package:easy_blood/component/input_container.dart';
import 'package:easy_blood/constant.dart';
import 'package:flutter/material.dart';

class InputPasswordRound extends StatelessWidget {
  final ValueChanged<String> onchanged;
  final ValueChanged<String> deco;
  final TextEditingController controller;
  final ValueChanged<String> validator;
  const InputPasswordRound({
    this.validator,
    this.onchanged,
    this.deco,
    this.controller,
    Key key,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: true,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(Icons.lock,
          color: kThirdColor,),
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.visibility,
            color: Color(0xFF2b2024),
          ),
        ),
      ),

    );
  }
}

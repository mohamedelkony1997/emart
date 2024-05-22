import 'package:emart/consts/consts.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPress, color, textcolor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.all(10),
      ),
      onPressed: onPress,
      child: title!.text.color(textcolor).size(16).fontFamily(bold).make());
}

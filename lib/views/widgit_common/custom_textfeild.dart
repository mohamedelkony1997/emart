// ignore_for_file: prefer_const_constructors

import 'package:emart/consts/consts.dart';
import 'package:flutter/material.dart';

Widget custom_textFeild({String? title, String? hint, controller,ispass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.fontFamily(semibold).color(redColor).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: ispass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontFamily: semibold, color: textfieldGrey),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: redColor)),
        ),
      ),
      5.heightBox,
    ],
  );
}

import 'package:emart/consts/consts.dart';
import 'package:flutter/material.dart';

Widget applogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(70, 70)
      .padding(EdgeInsets.all(8))
      .rounded
      .make();
}

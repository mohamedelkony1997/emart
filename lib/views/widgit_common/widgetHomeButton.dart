// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:emart/consts/consts.dart';
import 'package:flutter/widgets.dart';

Widget homeButtons({width, height, icon, String? title, onpress}) {
  return Container(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ]),
  ).box.rounded.white.size(width, height).shadowSm.make();
}

import 'package:emart/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      "$count".text.fontFamily(semibold).size(16).color(darkFontGrey).make(),
      "$title".text.color(darkFontGrey).make()
    ],
  ).box.white.rounded.width(width).height(50).padding(EdgeInsets.all(4)).make();
}

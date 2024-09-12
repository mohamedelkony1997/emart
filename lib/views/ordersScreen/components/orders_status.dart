import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:flutter/material.dart';

Widget OrderStatus({icon,color,title,showdown}) {
  return ListTile(
leading: Icon(icon,color: color,).box.roundedSM.padding(EdgeInsets.all(4)).make(),
trailing: SizedBox(
  height: 100,
  width: 120,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    "$title".text.color(darkFontGrey).make(),
    showdown? Icon(Icons.done,color: redColor,):Container(),
  
  ],),
),

  );
}

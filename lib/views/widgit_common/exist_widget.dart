import 'package:emart/consts/consts.dart';
import 'package:emart/views/widgit_common/our_buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

Widget existDailog(Context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you Sure you want To exist"
            .text
            .size(16)
            .fontFamily(bold)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textcolor: whiteColor,
                title: "Yes"),
            ourButton(
                color: redColor,
                onPress: () {
                  Navigator.pop(Context);
                },
                textcolor: whiteColor,
                title: "No")
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}

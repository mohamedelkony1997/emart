import 'package:emart/consts/consts.dart';
import 'package:emart/views/categories/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget featuredHomeButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 40,
        fit: BoxFit.fill,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .padding(EdgeInsets.all(4))
      .roundedSM.outerShadowSm
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}

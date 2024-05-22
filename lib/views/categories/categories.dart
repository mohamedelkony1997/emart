import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/consts/strings.dart';
import 'package:emart/views/categories/category_details.dart';
import 'package:emart/views/widgit_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return bgwidget(Scaffold(
      appBar: AppBar(title: categories.text.fontFamily(bold).white.make()),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  categoriesimages[index],
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                10.heightBox,
                "${categorieslist[index]}"
                    .text
                    .color(darkFontGrey)
                    .align(TextAlign.center)
                    .make()
              ],
            )
                .box
                .rounded
                .white
                .clip(Clip.antiAlias)
                .outerShadowSm
                .make()
                .onTap(() {
              Get.to(CategoryDetails(
                title: categorieslist[index],
              ));
            });
          },
        ),
      ),
    ));
  }
}

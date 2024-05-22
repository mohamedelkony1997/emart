import 'package:emart/consts/consts.dart';
import 'package:emart/views/categories/item_details.dart';
import 'package:emart/views/widgit_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  String title;
  CategoryDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgwidget(SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: title.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    6,
                    (index) => "BabyClothing"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .rounded
                        .white
                        .size(150, 60)
                        .margin(EdgeInsets.symmetric(horizontal: 4))
                        .make()),
              ),
            ),
            20.heightBox,
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10),
              color: lightGrey,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        imgP5,
                        height: 150,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      "Laptop 4GB/64GB"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      "\$600"
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(16)
                          .make(),
                      10.heightBox,
                    ],
                  )
                      .box
                      .roundedSM
                      .outerShadowSm
                      .padding(EdgeInsets.all(12))
                      .white
                      .margin(EdgeInsets.symmetric(horizontal: 4))
                      .make()
                      .onTap(() {
                    Get.to(ItemDetails(title: "Dummy"));
                  });
                },
              ),
            ))
          ]),
        ),
      ),
    ));
  }
}

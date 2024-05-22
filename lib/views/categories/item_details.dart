// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/views/widgit_common/our_buttonWidget.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  ItemDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: darkFontGrey,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_outline,
                  color: darkFontGrey,
                )),
          ]),
      body: Column(children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                VxSwiper.builder(
                  autoPlay: true,
                  height: 350,
                  aspectRatio: 16 / 9,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imgFc5,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                10.heightBox,
                title.text
                    .fontFamily(semibold)
                    .size(16)
                    .color(darkFontGrey)
                    .make(),
                10.heightBox,
                VxRating(
                  onRatingUpdate: (value) {},
                  normalColor: textfieldGrey,
                  selectionColor: golden,
                  stepInt: true,
                  size: 25,
                  count: 5,
                ),
                10.heightBox,
                "\$30,000"
                    .text
                    .color(redColor)
                    .size(18)
                    .fontFamily(bold)
                    .make(),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        "Seller".text.white.fontFamily(semibold).make(),
                        5.heightBox,
                        "In House Brands"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make()
                      ],
                    )),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.message_rounded,
                        color: darkFontGrey,
                      ),
                    ),
                  ],
                )
                    .box
                    .height(60)
                    .color(textfieldGrey)
                    .padding(EdgeInsets.symmetric(horizontal: 16))
                    .make(),
                20.heightBox,
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Color : ".text.color(textfieldGrey).make(),
                        ),
                        Row(
                          children: List.generate(
                              3,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Vx.randomPrimaryColor)
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .make()),
                        ),
                      ],
                    ).box.padding(EdgeInsets.all(8)).make(),
                    20.heightBox,
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Quantity : ".text.color(textfieldGrey).make(),
                        ),
                        Row(children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.remove)),
                          "0"
                              .text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),
                          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                          10.widthBox,
                          "0 avialable".text.color(textfieldGrey).make(),
                        ]),
                      ],
                    ).box.padding(EdgeInsets.all(8)).make(),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Total : ".text.color(textfieldGrey).make(),
                        ),
                        "\$0.00"
                            .text
                            .color(redColor)
                            .size(16)
                            .fontFamily(bold)
                            .make(),
                      ],
                    ).box.padding(EdgeInsets.all(8)).make(),
                  ],
                ).box.shadowSm.white.make(),
                10.heightBox,
                "Description"
                    .text
                    .fontFamily(semibold)
                    .color(darkFontGrey)
                    .make(),
                "This is dummy item and dummy description here.."
                    .text
                    .color(textfieldGrey)
                    .make(),
                10.heightBox,
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                      itemsdetailsbuttonList.length,
                      (index) => ListTile(
                            title: "${itemsdetailsbuttonList[index]}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: Icon(Icons.arrow_forward),
                          )),
                ),
                productsyoumylike.text
                    .size(16)
                    .color(darkFontGrey)
                    .fontFamily(bold)
                    .make(),
                10.heightBox,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        6,
                        (index) => Column(
                              children: [
                                Image.asset(
                                  imgP1,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
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
                                    .make()
                              ],
                            )
                                .box
                                .margin(EdgeInsets.symmetric(horizontal: 6))
                                .white
                                .roundedSM
                                .padding(EdgeInsets.all(8))
                                .make()),
                  ),
                ),
              ])),
        )),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ourButton(
            color: redColor,
            onPress: () {},
            textcolor: whiteColor,
            title: "Add To Cart",
          ),
        )
      ]),
    ));
  }
}

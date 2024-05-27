// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controlers/product_controller.dart';
import 'package:emart/views/widgit_common/our_buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  final dynamic data;
  ItemDetails({
    Key? key,
    required this.title,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return SafeArea(
        child: PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        controller.clearData();
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: redColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: whiteColor,),
              onPressed: () {
                controller.clearData();
                Get.back();
              },
            ),
            title: title.text.color(whiteColor).fontFamily(bold).make(),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share,
                    color: whiteColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_outline,
                    color: whiteColor,
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
                    viewportFraction: 1.0,
                    height: 250,
                    aspectRatio: 16 / 9,
                    itemCount: data["p_imgs"].length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        data["p_imgs"][index],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
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
                    value: double.parse(data["p_rating"]),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  "${data["p_price"]} AED"
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
                          "${data['p_seller']}"
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
                  Obx(
                    () => Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  "Color : ".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                              .size(30, 30)
                                              .roundedFull
                                              .color(
                                                  Color(data['p_colors'][index])
                                                      .withOpacity(1))
                                              .margin(EdgeInsets.symmetric(
                                                  horizontal: 4))
                                              .make()
                                              .onTap(() {
                                            controller
                                                .changecolorIndexint(index);
                                          }),
                                          Visibility(
                                            visible: index ==
                                                controller.colorindex.value,
                                            child: Icon(
                                              Icons.done,
                                              color: whiteColor,
                                            ),
                                          )
                                        ],
                                      )),
                            ),
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),
                        20.heightBox,
                        Obx(
                          () => Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity : "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Row(children: [
                                IconButton(
                                    onPressed: () {
                                      controller.decreaseQuantity();
                                      controller.calculateTotPrice(
                                          int.parse(data["p_price"]));
                                    },
                                    icon: Icon(Icons.remove)),
                                10.widthBox,
                                controller.Quantity.value.text
                                    .size(16)
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .make(),
                                10.widthBox,
                                IconButton(
                                    onPressed: () {
                                      controller.increaseQuantity(
                                          int.parse(data["p_quantity"]));
                                      controller.calculateTotPrice(
                                          int.parse(data["p_price"]));
                                    },
                                    icon: Icon(Icons.add)),
                                20.widthBox,
                                "${data["p_quantity"]} avialable"
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ]),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  " Total : ".text.color(textfieldGrey).make(),
                            ),
                            "${controller.totalPrice.value} AED"
                                .text
                                .color(redColor)
                                .size(16)
                                .fontFamily(bold)
                                .make(),
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),
                      ],
                    ).box.shadowSm.white.make(),
                  ),
                  10.heightBox,
                  "Description"
                      .text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .make(),
                  "${data["p_desc"]}".text.color(textfieldGrey).make(),
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
              onPress: () {
                controller.addToCart(
                  color: data["p_colors"][controller.colorindex.value],
                  context: context,
                  img: data["p_imgs"][0],
                  qty: controller.Quantity.value,
                  sellerName: data["p_seller"],
                  title: data["p_name"],
                  tprice: controller.totalPrice.value,
                );
                VxToast.show(context, msg: "Added To Cart");
              },
              textcolor: whiteColor,
              title: "Add To Cart",
            ),
          )
        ]),
      ),
    ));
  }
}

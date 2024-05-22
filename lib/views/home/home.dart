// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/views/widgit_common/featuredButton.dart';
import 'package:emart/views/widgit_common/widgetHomeButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: lightGrey,
      width: context.width,
      height: context.height,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            height: 60,
            alignment: Alignment.center,
            color: lightGrey,
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  fillColor: whiteColor,
                  filled: true,
                  hintText: search,
                  hintStyle: TextStyle(
                    color: textfieldGrey,
                  )),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                    autoPlay: true,
                    height: 150,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    itemCount: brandlist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Image.asset(
                          brandlist[index],
                          fit: BoxFit.fill,
                        ),
                      )
                          .box
                          .rounded
                          .clip(
                            Clip.antiAlias,
                          )
                          .margin(EdgeInsets.symmetric(horizontal: 12))
                          .make();
                    },
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                              height: context.height * .15,
                              width: context.width / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? today : flashsale,
                            )),
                  ),
                  10.heightBox,
                  VxSwiper.builder(
                    autoPlay: true,
                    height: 150,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    itemCount: secondsliderlist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Image.asset(
                          secondsliderlist[index],
                          fit: BoxFit.fill,
                        ),
                      )
                          .box
                          .rounded
                          .clip(
                            Clip.antiAlias,
                          )
                          .margin(EdgeInsets.symmetric(horizontal: 12))
                          .make();
                    },
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButtons(
                            height: context.height * .15,
                            width: context.width / 4,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? topcategory
                                : index == 1
                                    ? brand
                                    : topseller)),
                  ),
                  10.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredcategory.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make()),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredHomeButton(
                                      icon: featuresimages1[index],
                                      title: featurestitles1[index]),
                                  10.heightBox,
                                  featuredHomeButton(
                                      icon: featuresimages2[index],
                                      title: featurestitles2[index]),
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: redColor),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredproduct.text
                              .fontFamily(bold)
                              .white
                              .size(18)
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
                                          .margin(EdgeInsets.symmetric(
                                              horizontal: 6))
                                          .white
                                          .roundedSM
                                          .padding(EdgeInsets.all(8))
                                          .make()),
                            ),
                          ),
                        ]),
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                    autoPlay: true,
                    height: 150,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    itemCount: secondsliderlist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Image.asset(
                          secondsliderlist[index],
                          fit: BoxFit.fill,
                        ),
                      )
                          .box
                          .rounded
                          .clip(
                            Clip.antiAlias,
                          )
                          .margin(EdgeInsets.symmetric(horizontal: 12))
                          .make();
                    },
                  ),
                  20.heightBox,
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(
                            imgP5,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          Spacer(),
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
                          .padding(EdgeInsets.all(12))
                          .white
                          .margin(EdgeInsets.symmetric(horizontal: 4))
                          .make();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

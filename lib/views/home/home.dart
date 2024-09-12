// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controlers/home_controlers.dart';
import 'package:emart/controlers/product_controller.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/categories/item_details.dart';
import 'package:emart/views/home/serach_screen.dart';
import 'package:emart/views/widgit_common/featuredButton.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:emart/views/widgit_common/widgetHomeButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
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
              controller: controller.searchcontroller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search).onTap(() {
                  if(controller.searchcontroller.text.isNotEmptyAndNotNull){
                      Get.to(() => SearchScreen(
                          title: controller.searchcontroller.text,
                        ));
                  }
                  }),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: double.infinity,
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
                              child: FutureBuilder(
                                future: FireStoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: LoadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No Featured Products"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredproducts = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                          featuredproducts.length,
                                          (index) => Column(
                                                children: [
                                                  Image.network(
                                                    "${featuredproducts[index]["p_imgs"][0]}",
                                                    width: 100,
                                                    height: 120,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  10.heightBox,
                                                  "${featuredproducts[index]["p_name"]}"
                                                      .text
                                                      .fontFamily(semibold)
                                                      .color(darkFontGrey)
                                                      .make(),
                                                  10.heightBox,
                                                  "${featuredproducts[index]["p_price"] != null ? "\$ ${featuredproducts[index]["p_price"]}" : "Price not available"}"
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
                                                  .make()
                                                  .onTap(() {
                                                Get.to(() => ItemDetails(
                                                      title:
                                                          "${featuredproducts[index]["p_name"]}",
                                                      data: featuredproducts[
                                                          index],
                                                    ));
                                              })),
                                    );
                                  }
                                },
                              )),
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
                  "All Products"
                      .text
                      .color(darkFontGrey)
                      .fontFamily(bold)
                      .size(22)
                      .make(),
                  StreamBuilder(
                    stream: FireStoreServices.allProducts(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return LoadingIndicator();
                      } else {
                        var allproducts = snapshot.data!.docs;
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: allproducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  "${allproducts[index]["p_imgs"][0]}",
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                Spacer(),
                                "${allproducts[index]["p_name"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${allproducts[index]["p_price"]}"
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
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetails(
                                    title: "${allproducts[index]["p_name"]}",
                                    data: allproducts[index],
                                  ));
                            });
                          },
                        );
                      }
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

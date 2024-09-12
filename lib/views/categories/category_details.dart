import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controlers/product_controller.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/categories/item_details.dart';
import 'package:emart/views/widgit_common/bg_widget.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  String title;
  CategoryDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    switchCategory(widget.title);
    super.initState();
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FireStoreServices.getAllSubCategoryProducts(title);
    } else {
      productMethod = FireStoreServices.getProducts(title);
    }
  }

  var controller = Get.put(ProductController());

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgwidget(SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: widget.title.text.white.fontFamily(bold).make(),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      controller.subcat.length,
                      (index) => "${controller.subcat[index]}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .makeCentered()
                              .box
                              .rounded
                              .white
                              .size(150, 60)
                              .margin(EdgeInsets.symmetric(horizontal: 4))
                              .make()
                              .onTap(() {
                            switchCategory("${controller.subcat[index]}");
                            setState(() {
                              
                            });
                          })),
                ),
              ),
              20.heightBox,
              StreamBuilder<QuerySnapshot>(
                stream: productMethod,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: Center(
                        child: LoadingIndicator(),
                      ),
                    );
                  } else if (snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: "No Products Found".text.color(darkFontGrey).makeCentered(),
                    );
                  } else {
                    var products = snapshot.data!.docs;
                    return Expanded(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          var product = products[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                product['p_imgs'][0],
                                height: 150,
                                width: 200,
                                fit: BoxFit.fill,
                              ).box.roundedSM.clip(Clip.antiAlias).make(),
                              5.heightBox,
                              "${product['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${product['p_price']} AED"
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
                            controller.checkIsFav(product);
                            Get.to(ItemDetails(
                              title: product['p_name'],
                              data: product,
                            ));
                          });
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          )),
    ));
  }
}

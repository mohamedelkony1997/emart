import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/controlers/cart_controller.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/cart/shipping_info.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:emart/views/widgit_common/our_buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: SizedBox(
              height: 60,
              child: ourButton(
                  color: redColor,
                  onPress: () {
                    Get.to(() => ShippingInfo());
                  },
                  textcolor: whiteColor,
                  title: "Proceed To Shipping"),
            ),
            backgroundColor: whiteColor,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: whiteColor,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              automaticallyImplyLeading: false,
              backgroundColor: redColor,
              title: "Shopping Cart"
                  .text
                  .color(whiteColor)
                  .fontFamily(bold)
                  .make(),
            ),
            body: StreamBuilder(
              stream: FireStoreServices.getCart(user!.uid),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: LoadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: "No Items Added to The Cart"
                        .text
                        .color(darkFontGrey)
                        .make(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  controller.calculateCart(data);
                  controller.productSnapshot = data;
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(data[index].id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                FireStoreServices.deleteCartItem(
                                    data[index].id);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Item deleted")),
                                );
                              },
                              background: Container(
                                color: whiteColor,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: lightGrey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          "${data[index]["img"]}",
                                          height: 120,
                                          fit: BoxFit.fill,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                        )),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            " Name: "
                                                .text
                                                .fontFamily(semibold)
                                                .size(13)
                                                .color(fontGrey)
                                                .make(),
                                            "${data[index]["title"]}"
                                                .text
                                                .fontFamily(semibold)
                                                .size(13)
                                                .make(),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            "Quantity: "
                                                .text
                                                .fontFamily(semibold)
                                                .color(fontGrey)
                                                .size(13)
                                                .make(),
                                            "${data[index]["qty"]}"
                                                .text
                                                .fontFamily(semibold)
                                                .size(13)
                                                .make(),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            "Total: "
                                                .text
                                                .fontFamily(semibold)
                                                .size(13)
                                                .color(fontGrey)
                                                .make(),
                                            "${data[index]["total"]} AED"
                                                .text
                                                .color(darkFontGrey)
                                                .size(13)
                                                .fontFamily(semibold)
                                                .make(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Total Price "
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            Obx(() => "${controller.totalP.value}"
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make()),
                          ],
                        )
                            .box
                            .padding(EdgeInsets.all(12))
                            .width(context.screenWidth - 60)
                            .color(lightGrey)
                            .rounded
                            .make(),
                      ],
                    ),
                  );
                }
              },
            )));
  }
}

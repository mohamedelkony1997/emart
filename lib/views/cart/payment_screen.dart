import 'dart:ffi';

import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controlers/cart_controller.dart';
import 'package:emart/views/home/HomeScreen.dart';
import 'package:emart/views/home/home.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:emart/views/widgit_common/our_buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cartcontroller = Get.find<CartController>();
    return Obx(
      () => SafeArea(
          child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: (cartcontroller.placingOrder.value)
              ? Center(
                  child: LoadingIndicator(),
                )
              : ourButton(
                  color: redColor,
                  onPress: () async {
                    await cartcontroller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[cartcontroller.paymentIndex.value],
                        totalAmount: cartcontroller.totalP.value);
                    await cartcontroller.clearCart();
                      VxToast.show(context, msg: "Order Placed Successefully");
                    Get.offAll(HomeScreen());
                  
                  },
                  textcolor: whiteColor,
                  title: "Place My Order"),
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
          backgroundColor: redColor,
          title: "Choose Payement Method "
              .text
              .color(whiteColor)
              .fontFamily(bold)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(
                paymentMethodsimgs.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      cartcontroller.changePaymentMethod(index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: cartcontroller.paymentIndex.value == index
                                ? darkFontGrey
                                : Colors.transparent,
                            width: 3,
                          )),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            "${paymentMethodsimgs[index]}",
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          cartcontroller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                      activeColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      value: true,
                                      onChanged: (value) {}),
                                )
                              : SizedBox(),
                          Positioned(
                              bottom: 10,
                              right: 10,
                              child: paymentMethods[index]
                                  .text
                                  .white
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      )),
    );
  }
}

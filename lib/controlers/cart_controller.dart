import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/controlers/home_controlers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();
  var totalP = 0.obs;
  var paymentIndex = 0.obs;
  var placingOrder = false.obs;
  late dynamic productSnapshot;
  var products = [];

  void calculateCart(data) {
    totalP.value = 0;
    for (var item in data) {
      totalP.value += int.parse(item["total"].toString());
    }
  }

  void changePaymentMethod(int index) {
    paymentIndex.value = index;
  }

  Future<void> placeMyOrder(
      {required String orderPaymentMethod, required int totalAmount}) async {
    placingOrder(true);
    getProductsDetails();
    var homeController = Get.find<HomeController>();
    await firestore.collection(ordercollection).doc().set({
      "order_code": "23255",
      "order_createdAt": FieldValue.serverTimestamp(),
      "order_by": user!.uid,
      "order_by_name": homeController.userName.value, // Access the string value
      "order_by_email": user!.email,
      "order_by_address": addressController.text,
      "order_by_city": cityController.text,
      "order_by_state": stateController.text,
      "order_by_phone": phoneController.text,
      "order_by_postalCode": postalCodeController.text,
      "shipping_method": "Home Delivery",
      "payment_method": orderPaymentMethod,
      "order_placed": true,
      "order_confirmed": false,
      "order_delivered": false,
      "order_onDelivery": false,
      "total_amount": totalAmount,
      "orders": FieldValue.arrayUnion(products),
    });
    placingOrder(false);
  }

  void getProductsDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        "color": productSnapshot[i]['color'],
        "img": productSnapshot[i]['img'],
        "vendor_id": productSnapshot[i]['vendor_id'],
        "tprice": productSnapshot[i]['total'],
        "qty": productSnapshot[i]['qty'],
        "title": productSnapshot[i]['title'],
      });
    }
    print(products);
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartcollection).doc(productSnapshot[i].id).delete();
    }
  }
}

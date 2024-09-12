import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/Models/catogory_model.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController {
  var Quantity = 0.obs;
  var colorindex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;
  var subcat = [];
  getsubcategory(title) async {
    subcat.clear();
    var data =
        await rootBundle.loadString("lib/services/categories_model.json");
    var decoded = catogoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changecolorIndexint(index) {
    colorindex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (Quantity.value < totalQuantity) Quantity.value++;
  }

  decreaseQuantity() {
    if (Quantity.value > 0) {
      Quantity.value--;
    }
  }

  calculateTotPrice(price) {
    totalPrice.value = price * Quantity.value;
  }

  addToCart({
    context,
    title,
    img,
    sellerName,
    color,
    qty,
    tprice,
    vendorId
  }) {
    firestore.collection(cartcollection).doc().set({
      "title": title,
      "img": img,
      "sellerName": sellerName,
      "color": color,
      "qty": qty,
      "total": tprice,
      "vendor_id": vendorId,
      "addedBy": user!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  clearData() {
    totalPrice.value = 0;
    colorindex.value = 0;
    Quantity.value = 0;
  }

  addToWishList(docId, context) async {
    await firestore.collection(productioncollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayUnion([user!.uid]),
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added");
  }

  removeToWishList(docId, context) async {
    await firestore.collection(productioncollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayRemove([user!.uid]),
    }, SetOptions(merge: true));
    
    isFav(false);
        VxToast.show(context, msg: "Removed");
  }

  checkIsFav(data) async {
    if (data["p_wishlist"].contains(user!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}

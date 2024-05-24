import 'package:emart/Models/catogory_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var Quantity = 0.obs;
  var colorindex = 0.obs;
  var totalPrice = 0.obs;
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
    totalPrice.value = price * Quantity.value ;
  }
}

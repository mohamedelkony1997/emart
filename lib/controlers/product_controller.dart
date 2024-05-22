import 'package:emart/Models/catogory_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
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
}

import 'package:meta/meta.dart';
import 'dart:convert';

CatogoryModel catogoryModelFromJson(String str) =>
    CatogoryModel.fromJson(json.decode(str));

class CatogoryModel {
  List<Category> categories;

  CatogoryModel({
    required this.categories,
  });

  factory CatogoryModel.fromJson(Map<String, dynamic> json) => CatogoryModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );
}

class Category {
  String name;
  List<String> subcategory;

  Category({
    required this.name,
    required this.subcategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );
}

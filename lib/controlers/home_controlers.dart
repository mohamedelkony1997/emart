import 'package:emart/consts/firebase_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var userName = "".obs;
  var userImage = "";
  var searchcontroller = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getUserName();
  }

  Future<void> getUserName() async {
    try {
      if (user != null) {
        var querySnapshot = await firestore
            .collection(usercollection)
            .where("Id", isEqualTo: user!.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.single;
          userName.value = userDoc['Name'] ?? 'N/A';
        } else {
          print("No user found with the given ID.");
        }
      } else {
        print("User is null.");
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }
}

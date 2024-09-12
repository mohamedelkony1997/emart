import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/views/home/HomeScreen.dart';
import 'package:emart/views/authScreen/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<UserCredential?> loginMethod({required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "An error occurred");
    }

    return userCredential;
  }

  Future<UserCredential?> signUpMethod({required String email, required String password, required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "An error occurred");
    }

    return userCredential;
  }

  Future<void> storeUserData({required String name, required String email, required String password}) async {
    DocumentReference store = firestore.collection(usercollection).doc(user!.uid);
    await store.set({
      "Name": name,
      "Email": email,
      "Password": password,
      "ImageUrl": "",
      "Id": user!.uid,
      "cart_count": "00",
      "wishlist_count": [],
      "order_count": "00",
    });
  }

  Future<void> signOutMethod(BuildContext context) async {
    try {
      await auth.signOut();
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar("Error", "Failed to sign out: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }
}

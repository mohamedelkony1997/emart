import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isloadind = false.obs;
  var emailConroller = TextEditingController();
  var passwordConroller = TextEditingController();
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailConroller.text, password: passwordConroller.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    return userCredential;
  }

  Future<UserCredential?> signUpMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    return userCredential;
  }

  storeUserdate({name, email, password}) async {
    DocumentReference store =
        await firestore.collection(usercollection).doc(user!.uid);
    store.set({
      "Name": name,
      "Email": email,
      "Password": password,
      "ImageUrl": '',
      "Id": user!.uid,
      "cart_count": "00",
      "wishlist_count": "00",
      "order_count": "00",
    });
  }

  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}

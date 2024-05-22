import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';

import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/controlers/auth_controller.dart';
import 'package:emart/views/authScreen/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController {
  var nameConroller = TextEditingController();
  var oldpasswordConroller = TextEditingController();
  var newpasswordConroller = TextEditingController();
  var profilepath = ''.obs;
  var isLoading = false.obs;
  var profileimagelink = '';
  changeImahe(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profilepath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profilepath.value);
    var destination = 'Images/${user!.uid}/$filename';
    Reference reference = FirebaseStorage.instance.ref(destination);
    await reference.putFile(File(profilepath.value));
    profileimagelink = await reference.getDownloadURL();
  }

  updateProfile({name, password, ImgUrl}) async {
    var store = firestore.collection(usercollection).doc(user!.uid);
    await store.set({
      "Name": name,
      "Password": password,
      "ImageUrl": ImgUrl,
    }, SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthpassword({email, password, newpassword}) async {
    try {
      final cred =
          EmailAuthProvider.credential(email: email, password: password);
      await user!.reauthenticateWithCredential(cred);
      await user!.updatePassword(newpassword);
    } catch (e) {
      print(e.toString());
    }
  }
}

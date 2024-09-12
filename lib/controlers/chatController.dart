import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/controlers/home_controlers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatcollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName =
      Get.find<HomeController>().userName.value; // Access the string value
  var currentId = user!.uid;
  var msgController = TextEditingController();
  var isLoading = false.obs;
  dynamic chatDocId;

  getChatId() async {
    isLoading(true);
    await chats
        .where("users", isEqualTo: {
          friendId: null,
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapShots) {
          if (snapShots.docs.isNotEmpty) {
            chatDocId = snapShots.docs.single.id;
          } else {
            chats.add({
              "created_on": null,
              "users": {
                friendId: null,
                currentId: null,
              },
              "toId": "",
              "fromId": "",
              "friendName": friendName,
              "senderName": senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isLoading(false);
  }

  sendMsg(msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        "created_on": FieldValue.serverTimestamp(),
        "last_msg": msg,
        "toId": friendId,
        "fromId": currentId,
      });
      chats.doc(chatDocId).collection(messagecollection).doc().set({
        "created_on": FieldValue.serverTimestamp(),
        "msg": msg,
        "uid": currentId,
      });
      getChatId();
    }
  }
}

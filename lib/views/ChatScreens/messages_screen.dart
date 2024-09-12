import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/colors.dart';
import 'package:emart/consts/styles.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/ChatScreens/chat_screen.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: whiteColor,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              backgroundColor: redColor,
              title:
                  "My Messages".text.color(whiteColor).fontFamily(bold).make(),
            ),
            body: StreamBuilder(
              stream: FireStoreServices.getAllMessages(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: LoadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: "No Messsages yet".text.color(darkFontGrey).make(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => ChatScreen(), arguments: [
                                    data[index]["friendName"].toString(),
                                    data[index]["toId"].toString(),
                                  ]);
                                },
                                leading: CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Icon(
                                    Icons.person,
                                    color: whiteColor,
                                  ),
                                ),
                                title: "${data[index]["friendName"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                subtitle: "${data[index]["last_msg"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                              ),
                            );
                          },
                        ))
                      ],
                    ),
                  );
                }
              },
            )));
  }
}

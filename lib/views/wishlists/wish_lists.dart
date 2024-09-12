import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/colors.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/consts/styles.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class WishLists extends StatelessWidget {
  const WishLists({super.key});

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
          title: "My WishLists".text.color(whiteColor).fontFamily(bold).make(),
        ),
        body: StreamBuilder(
          stream: FireStoreServices.getAllWishlist(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No WishLists yet".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            "${data[index]["p_imgs"][0]}",
                            height: 120,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width - 150,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Row(
                              children: [
                                " Name: "
                                    .text
                                    .fontFamily(semibold)
                                    .size(13)
                                    .color(fontGrey)
                                    .make(),
                                "${data[index]["p_name"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .size(13)
                                    .make(),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                "Total: "
                                    .text
                                    .fontFamily(semibold)
                                    .size(13)
                                    .color(fontGrey)
                                    .make(),
                                "${data[index]["p_price"]} AED"
                                    .text
                                    .color(darkFontGrey)
                                    .size(13)
                                    .fontFamily(semibold)
                                    .make(),
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Icons.favorite,
                              color: redColor,
                            ).onTap(() async {
                              await firestore
                                  .collection(productioncollection)
                                  .doc(data[index].id)
                                  .set({
                                "p_wishlist":
                                    FieldValue.arrayRemove([user!.uid])
                              }, SetOptions(merge: true));
                            }),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

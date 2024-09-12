import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/ordersScreen/orders_details.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OdersScreen extends StatelessWidget {
  const OdersScreen({super.key});

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
              title: "My Orders".text.color(whiteColor).fontFamily(bold).make(),
            ),
            body: StreamBuilder(
              stream: FireStoreServices.getAllOrders(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: LoadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: "No Orders yet".text.color(darkFontGrey).make(),
                  );
                } else {
                  var data = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: "${index + 1}"
                            .text
                            .fontFamily(bold)
                            .color(darkFontGrey)
                            .make(),
                        title: data[index]['order_code']
                            .toString()
                            .text
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                        subtitle: data[index]['total_amount']
                            .toString()
                            .numCurrency
                            .text
                            .fontFamily(bold)
                            .make(),
                        trailing: IconButton(
                            onPressed: () {
                              Get.to(() => OrdersDetails(data: data[index]));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: darkFontGrey,
                            )),
                      );
                    },
                  );
                }
              },
            )));
  }
}

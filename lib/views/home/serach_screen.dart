import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/categories/item_details.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;

  const SearchScreen({Key? key, this.title}) : super(key: key);

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
          title: title!.text.color(whiteColor).fontFamily(bold).make(),
        ),
        body: FutureBuilder(
          future: FireStoreServices.getSearchProducts(title),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Products Found".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;

              // Filter data based on the search term (title)
              var filterdata = data
                  .where(
                    (element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase()),
                  )
                  .toList();

              if (filterdata.isEmpty) {
                return "No Products Found".text.makeCentered();
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: filterdata.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    var product = filterdata[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          "${product['p_imgs'][0]}",
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        Spacer(),
                        "${product['p_name']}"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        "${product['p_price']}"
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(16)
                            .make(),
                        10.heightBox,
                      ],
                    )
                        .box
                        .roundedSM
                        .padding(EdgeInsets.all(12))
                        .white
                        .margin(EdgeInsets.symmetric(horizontal: 4))
                        .make()
                        .onTap(() {
                      Get.to(() => ItemDetails(
                            title: "${product['p_name']}",
                            data: product,
                          ));
                    });
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

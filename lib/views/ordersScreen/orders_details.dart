// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:emart/views/ordersScreen/components/order_details-place.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:emart/consts/consts.dart';
import 'package:emart/views/ordersScreen/components/orders_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({
    Key? key,
    required this.data,
  }) : super(key: key);

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
              "Orders Details".text.color(whiteColor).fontFamily(bold).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                OrderStatus(
                    color: redColor,
                    icon: Icons.done,
                    title: "Placed",
                    showdown: data["order_placed"]),
                OrderStatus(
                    color: Colors.blue,
                    icon: Icons.thumb_up,
                    title: "Confirmed",
                    showdown: data["order_confirmed"]),
                OrderStatus(
                    color: Colors.yellow,
                    icon: Icons.car_crash,
                    title: "On Delivery",
                    showdown: data["order_onDelivery"]),
                OrderStatus(
                    color: Colors.purple,
                    icon: Icons.done_all_rounded,
                    title: "Delivered",
                    showdown: data["order_delivered"]),
                Divider(),
                10.heightBox,
                Column(
                  children: [
                    orderdetailsplaced(
                        title: "Order Code",
                        title2: "Shipping Method",
                        d1: data["order_code"],
                        d2: data["shipping_method"]),
                    orderdetailsplaced(
                        title: "Order Date",
                        title2: "Payment Method",
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((data["order_createdAt"]).toDate()),
                        d2: data["shipping_method"]),
                    orderdetailsplaced(
                      title: "Order Date",
                      title2: "Order Placed",
                      d1: "Unpaid",
                      d2: " Delivery  Status",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data["order_by_name"]}".text.make(),
                              "${data["order_by_email"]}".text.make(),
                              "${data["order_by_address"]}".text.make(),
                              "${data["order_by_city"]}".text.make(),
                              "${data["order_by_state"]}".text.make(),
                              "${data["order_by_phone"]}".text.make(),
                              "${data["order_by_postalCode"]}".text.make(),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data["total_amount"]}"
                                  .text
                                  .fontFamily(bold)
                                  .color(redColor)
                                  .make(),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ).box.outerShadowSm.white.make(),
                Divider(),
                10.heightBox,
                "Order Product"
                    .text
                    .size(16)
                    .color(darkFontGrey)
                    .fontFamily(bold)
                    .makeCentered(),
                10.heightBox,
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(data["orders"].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderdetailsplaced(
                          title: data["orders"][index]["title"],
                          title2: data["orders"][index]["tprice"],
                          d1: "${data["orders"][index]["qty"]}x",
                          d2: "Refundable",
                        ),
                        Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                           
                            height: 10,
                            width: 30,
                            color: Color(data["orders"][index]["color"]),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
                ).box.outerShadowSm.white.margin(EdgeInsets.only(bottom:  4)).make(),
                20.heightBox,
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

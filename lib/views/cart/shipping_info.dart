import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controlers/cart_controller.dart';
import 'package:emart/views/cart/payment_screen.dart';
import 'package:emart/views/widgit_common/custom_textfeild.dart';
import 'package:emart/views/widgit_common/our_buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingInfo extends StatelessWidget {
  ShippingInfo({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              color: redColor,
              onPress: () {
                if (_formKey.currentState!.validate()) {
                  Get.to(() => PaymentScreen());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              textcolor: whiteColor,
              title: "Continue"),
        ),
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
          title: "Shopping Info".text.color(whiteColor).fontFamily(bold).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  custom_textFeild(
                      hint: "Address",
                      ispass: false,
                      title: "Address",
                      msg: "Enter your address",
                      controller: cartController.addressController),
                  custom_textFeild(
                      hint: "City",
                      ispass: false,
                      title: "City",
                      msg: "Enter your city",
                      controller: cartController.cityController),
                  custom_textFeild(
                      hint: "State",
                      ispass: false,
                      msg: "Enter your state",
                      title: "State",
                      controller: cartController.stateController),
                  custom_textFeild(
                      hint: "Postal Code",
                      ispass: false,
                      title: "Postal Code",
                      msg: "Enter your postal code",
                      controller: cartController.postalCodeController),
                  custom_textFeild(
                      hint: "Phone",
                      ispass: false,
                      title: "Phone",
                      msg: "Enter your phone",
                      controller: cartController.phoneController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controlers/auth_controller.dart';
import 'package:emart/views/home/HomeScreen.dart';
import 'package:emart/views/authScreen/signUpScreen.dart';
import 'package:emart/views/widgit_common/bg_widget.dart';
import 'package:emart/views/widgit_common/custom_textfeild.dart';
import 'package:emart/views/widgit_common/logo_widget.dart';
import 'package:emart/views/widgit_common/our_buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var controller = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: bgwidget(
        Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  (context.screenHeight * .1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "Log in to $appname"
                      .text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  10.heightBox,
                  Obx(
                    () => Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          custom_textFeild(
                            hint: emailHint,
                            title: email,
                            ispass: false,
                            msg: "Enter your email",
                            controller: controller.emailController,
                          ),
                          custom_textFeild(
                            hint: passwordhint,
                            title: password,
                            ispass: true,
                            msg: "Enter your password",
                            controller: controller.passwordController,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: forgPassword.text.bold.make(),
                            ),
                          ),
                          controller.isLoading.value
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                )
                              : ourButton(
                                  color: redColor,
                                  textcolor: whiteColor,
                                  title: login,
                                  onPress: () async {
                                    if (_formKey.currentState!.validate()) {
                                      controller.isLoading(true);
                                      await controller
                                          .loginMethod(context: context)
                                          .then((value) {
                                        if (value != null) {
                                          VxToast.show(context, msg: logined);
                                          Get.offAll(() => HomeScreen());
                                        } else {
                                          controller.isLoading(false);
                                        }
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                  },
                                ).box.width(context.screenWidth - 50).make(),
                          10.heightBox,
                          createNewAcocount.text.color(fontGrey).make(),
                          5.heightBox,
                          ourButton(
                            color: lightGrey,
                            textcolor: redColor,
                            title: signup,
                            onPress: () {
                              Get.to(SignUpScreen());
                            },
                          ).box.width(context.screenWidth - 50).make(),
                          10.heightBox,
                          loginWith.text.color(fontGrey).make(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: lightGrey,
                                  child: Image.asset(
                                    socialListIcons[index],
                                    width: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                          .box
                          .white
                          .rounded
                          .padding(const EdgeInsets.all(16))
                          .width(context.screenWidth >= 70
                              ? context.screenWidth - 70
                              : context.screenWidth)
                          .shadowSm
                          .make(),
                    ),
                  ),
                  10.heightBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

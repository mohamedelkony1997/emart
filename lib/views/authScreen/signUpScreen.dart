// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:emart/consts/consts.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/controlers/auth_controller.dart';
import 'package:emart/views/HomeScreen/HomeScreen.dart';
import 'package:emart/views/authScreen/loginScreen.dart';

import 'package:emart/views/widgit_common/bg_widget.dart';
import 'package:emart/views/widgit_common/custom_textfeild.dart';
import 'package:emart/views/widgit_common/our_buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgit_common/logo_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  var controller = Get.put(AuthController());
  var nameConroller = TextEditingController();
  var emailConroller = TextEditingController();
  var passwordConroller = TextEditingController();
  var retypePasswordConroller = TextEditingController();
  
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
                  "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
                  10.heightBox,
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        custom_textFeild(
                          hint: namehint,
                          title: name,
                          controller: nameConroller,
                          ispass: false,
                        ),
                        custom_textFeild(
                          hint: emailHint,
                          title: email,
                          controller: emailConroller,
                          ispass: false,
                        ),
                        custom_textFeild(
                          hint: passwordhint,
                          title: password,
                          controller: passwordConroller,
                          ispass: true,
                        ),
                        custom_textFeild(
                          hint: passwordhint,
                          title: retyppassword,
                          controller: retypePasswordConroller,
                          ispass: true,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: redColor,
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            10.widthBox,
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "I agree to The ",
                                      style: TextStyle(fontFamily: regular, color: fontGrey),
                                    ),
                                    TextSpan(
                                      text: termsAndcond,
                                      style: TextStyle(fontFamily: regular, color: redColor),
                                    ),
                                    TextSpan(
                                      text: "&",
                                      style: TextStyle(fontFamily: regular, color: redColor),
                                    ),
                                    TextSpan(
                                      text: privcyPolicy,
                                      style: TextStyle(fontFamily: regular, color: redColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        controller.isloadind.value
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              color: isChecked == true ? redColor : lightGrey,
                              textcolor: whiteColor,
                              title: signup,
                              onPress: () async {
                                if (isChecked != false) {
                                  controller.isloadind(true);
                                  try {
                                    await controller
                                      .signUpMethod(
                                        context: context,
                                        email: emailConroller.text,
                                        password: passwordConroller.text,
                                      )
                                      .then((value) {
                                        return controller.storeUserdate(
                                          name: nameConroller.text,
                                          email: emailConroller.text,
                                          password: passwordConroller.text,
                                        );
                                      })
                                      .then((value) {
                                        VxToast.show(context, msg: logined);
                                        Get.offAll(() => HomeScreen());
                                      });
                                  } catch (e) {
                                    auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                    controller.isloadind(false);
                                  }
                                }
                              },
                            ).box.width(context.screenWidth - 50).make(),
                        10.heightBox,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: alreadyHaveAccount,
                                style: TextStyle(fontFamily: regular, color: fontGrey),
                              ),
                              TextSpan(
                                text: login,
                                style: TextStyle(fontFamily: regular, color: redColor),
                              ),
                            ],
                          ),
                        ).onTap(() {
                          Get.back();
                        }),
                      ],
                    )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
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

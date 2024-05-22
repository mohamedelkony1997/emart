// ignore_for_file: prefer_const_constructors

import 'package:emart/consts/consts.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/views/HomeScreen/HomeScreen.dart';
import 'package:emart/views/authScreen/loginScreen.dart';
import 'package:emart/views/widgit_common/logo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  changeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => LoginScreen());
        } else {
          Get.to(() => HomeScreen());
        }
      });
      Get.to(LoginScreen());
    });
  }

  @override
  void initState() {
    changeScreen(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: redColor,
      body: Center(
          child: Column(
        children: [
          Container(),
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              )),
          20.heightBox,
          applogoWidget(),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          5.heightBox,
        ],
      )),
    ));
  }
}

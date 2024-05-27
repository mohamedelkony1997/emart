// ignore_for_file: prefer_const_constructors

import 'package:emart/consts/consts.dart';
import 'package:emart/controlers/home_controlers.dart';
import 'package:emart/views/cart/cart.dart';
import 'package:emart/views/categories/categories.dart';
import 'package:emart/views/home/home.dart';
import 'package:emart/views/profile/Profile.dart';
import 'package:emart/views/widgit_common/exist_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controler = Get.put(HomeControler());
    var barItems = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account)
    ];
    var navBody = [Home(), Categories(), Cart(), Profile()];
    return SafeArea(
        child: PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => existDailog(context));
       
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controler.currentIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controler.currentIndex.value,
            items: barItems,
            selectedItemColor: redColor,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              fontFamily: semibold,
            ),
            backgroundColor: whiteColor,
            onTap: (value) {
              controler.currentIndex.value = value;
            },
          ),
        ),
      ),
    ));
  }
}

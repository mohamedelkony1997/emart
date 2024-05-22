import 'package:emart/views/splashScreens/splashScreen.dart';
import 'package:emart/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: darkFontGrey)),
          fontFamily: regular),
      home: SpalshScreen(),
    );
  }
}

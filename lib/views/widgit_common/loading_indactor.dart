import 'package:emart/consts/colors.dart';
import 'package:flutter/material.dart';

Widget LoadingIndicator() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}

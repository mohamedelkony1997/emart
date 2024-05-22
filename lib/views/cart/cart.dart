import 'package:emart/consts/consts.dart';

import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: "Cart Is Empty"
          .text
          .fontFamily(semibold)
          .color(darkFontGrey)
          .makeCentered(),
    );
  }
}

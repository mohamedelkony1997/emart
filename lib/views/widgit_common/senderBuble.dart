import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/colors.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBuble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat('h:mma').format(t);
  return Directionality(
    textDirection: data["uid"]==user!.uid?TextDirection.rtl:TextDirection.ltr,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft:Radius.circular(data["uid"]==user!.uid?20:-20),
          bottomRight: Radius.circular(data["uid"]==user!.uid? 0:20),
        ),
        color:data["uid"]==user!.uid? redColor:lightGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${data['msg']}",
            style: GoogleFonts.cairo(
              color:data["uid"]==user!.uid? Colors.white:darkFontGrey,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "${time}",
            style: GoogleFonts.cairo(
                fontSize: 9, fontWeight: FontWeight.bold,  color:data["uid"]==user!.uid? Colors.white:darkFontGrey,),
          ),
        ],
      ),
    ),
  );
}

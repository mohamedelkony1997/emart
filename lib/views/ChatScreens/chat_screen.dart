import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/controlers/chatController.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:emart/views/widgit_common/senderBuble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';

int? _remoteUid;
bool _localUserJoined = false;

final FocusNode _focusNode = FocusNode();

class ChatScreen extends StatelessWidget {
  final ChatController _chatController = Get.put(ChatController());

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
            'assets/images/chatimage.jpeg'), // Change to your image path
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: redColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _chatController.friendName = "";
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${_chatController.friendName}",
                    style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 23),
                  ),
                  Spacer(),
                  ClipOval(
                    child: Image.asset(
                      "assets/images/profile_image.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => _chatController.isLoading.value
                ? Center(
                    child: LoadingIndicator(),
                  )
                : Expanded(
                    child: StreamBuilder(
                    stream: FireStoreServices.getChats(
                        _chatController.chatDocId.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: LoadingIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: "No Chat..".text.color(darkFontGrey).make(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data!.docs
                              .mapIndexed((currentvalue, index) {
                            var data = snapshot.data!.docs[index];
                            return Align(
                                alignment: data["uid"] == user!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: senderBuble(data));
                          }).toList(),
                        );
                      }
                    },
                  )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Color(0xffe2e3ed)),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      child: TextFormField(
                        controller: _chatController.msgController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(Icons.emoji_emotions),
                            onPressed: () {
                              _showEmojiPicker(context);
                            },
                          ),
                          border: InputBorder.none,
                          hintText: 'Type a message...',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: redColor, shape: BoxShape.circle),
                    child: Transform.rotate(
                      angle: -math.pi / 4,
                      child: IconButton(
                        icon: Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _chatController
                              .sendMsg(_chatController.msgController.text);
                          _chatController.msgController.clear();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }

  void _showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return EmojiPicker(
          onEmojiSelected: (category, emoji) {
            final currentText = _chatController.msgController.text;
            final newText = '$currentText${emoji.emoji}';

            _chatController.msgController.text = newText;

            // Set the cursor position to the end of the text
            _chatController.msgController.selection =
                TextSelection.fromPosition(
              TextPosition(offset: newText.length),
            );

            // Close the emoji picker
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

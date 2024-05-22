import 'dart:io';

import 'package:emart/consts/consts.dart';
import 'package:emart/consts/images.dart';
import 'package:emart/views/profile/ProfileController.dart';
import 'package:emart/views/widgit_common/bg_widget.dart';
import 'package:emart/views/widgit_common/custom_textfeild.dart';
import 'package:emart/views/widgit_common/our_buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Edit_profileScreen extends StatelessWidget {
  final dynamic data;
  const Edit_profileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgwidget(Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Builder(builder: (context) {
        return Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (controller.profilepath.isEmpty && data['ImageUrl'] == "")
                  ? Image.asset(
                      imgProfile2,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : (controller.profilepath.isEmpty && data['ImageUrl'] != "")
                      ? Image.network(
                          data['ImageUrl'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profilepath.value),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImahe(context);
                  },
                  textcolor: whiteColor,
                  title: "Change"),
              Divider(),
              20.heightBox,
              custom_textFeild(
                  hint: namehint,
                  ispass: false,
                  title: name,
                  controller: controller.nameConroller),
              10.heightBox,
              custom_textFeild(
                  hint: passwordhint,
                  ispass: true,
                  title: oldpass,
                  controller: controller.oldpasswordConroller),
              10.heightBox,
              custom_textFeild(
                  hint: passwordhint,
                  ispass: true,
                  title: newpassword,
                  controller: controller.newpasswordConroller),
              20.heightBox,
              controller.isLoading.value
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          color: redColor,
                          onPress: () async {
                            controller.isLoading(true);
                            if (controller.profilepath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileimagelink = data['ImageUrl'];
                            }
                            if (data['Password'] ==
                                controller.oldpasswordConroller.text) {
                              await controller.changeAuthpassword(
                                  email: data['Email'],
                                  password:
                                      controller.oldpasswordConroller.text,
                                  newpassword:
                                      controller.newpasswordConroller.text);
                              await controller.updateProfile(
                                  ImgUrl: controller.profileimagelink,
                                  name: controller.nameConroller.text,
                                  password:
                                      controller.newpasswordConroller.text);
                              VxToast.show(context, msg: "Updated");
                            } else {
                              VxToast.show(context, msg: "Wrong Old Password");
                              controller.isLoading(false);
                            }
                          },
                          textcolor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(EdgeInsets.all(16))
              .margin(EdgeInsets.only(top: 25, left: 12, right: 12))
              .rounded
              .make(),
        );
      }),
    ));
  }
}

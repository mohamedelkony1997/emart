import 'package:emart/consts/consts.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controlers/auth_controller.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/authScreen/loginScreen.dart';
import 'package:emart/views/profile/ProfileController.dart';
import 'package:emart/views/profile/componets/componets_detailscard.dart';
import 'package:emart/views/profile/edit_profileScreen.dart';
import 'package:emart/views/widgit_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgwidget(Scaffold(
        body: StreamBuilder(
      stream: FireStoreServices.getUser(user!.uid),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var dataprofile = snapshot.data!;
          return SafeArea(
            child: Container(
                child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        controller.nameConroller.text = dataprofile['Name'];
                        Get.to(() => Edit_profileScreen(
                              data: dataprofile,
                            ));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: whiteColor,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      (dataprofile['ImageUrl'] == "")
                          ? Image.asset(
                              imgProfile2,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              dataprofile['ImageUrl'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${dataprofile["Name"]}"
                              .text
                              .fontFamily(semibold)
                              .white
                              .make(),
                          "${dataprofile["Email"]}".text.white.make(),
                        ],
                      )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await Get.put(
                                AuthController().signOutMethod(context));
                            Get.offAll(() => LoginScreen());
                          },
                          child:
                              "LogOut".text.fontFamily(semibold).white.make())
                    ],
                  ),
                ),
                20.heightBox,
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      detailsCard(
                          count: "${dataprofile["cart_count"]}",
                          title: "In Your Cart",
                          width: context.screenWidth / 3.4),
                      detailsCard(
                          count: "${dataprofile["wishlist_count"]}",
                          title: "In Your WishList",
                          width: context.screenWidth / 3.4),
                      detailsCard(
                          count: "${dataprofile["order_count"]}",
                          title: "Your Orders",
                          width: context.screenWidth / 3.4),
                    ],
                  ),
                ),
                ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.asset(
                              profilebuttonsicons[index],
                              width: 22,
                            ),
                            title: "${profilebuttonslist[index]}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: lightGrey,
                          );
                        },
                        itemCount: profilebuttonslist.length)
                    .box
                    .white
                    .rounded
                    .margin(EdgeInsets.all(12))
                    .padding(EdgeInsets.symmetric(horizontal: 16))
                    .shadowSm
                    .make()
                    .box
                    .color(redColor)
                    .make()
              ],
            )),
          );
        }
      },
    )));
  }
}

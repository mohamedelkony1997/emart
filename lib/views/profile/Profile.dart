import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/firebase_consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controlers/auth_controller.dart';
import 'package:emart/services/firestoreservices.dart';
import 'package:emart/views/ChatScreens/messages_screen.dart';
import 'package:emart/views/home/HomeScreen.dart';
import 'package:emart/views/ordersScreen/oders_screen.dart';
import 'package:emart/views/profile/ProfileController.dart';
import 'package:emart/views/profile/componets/componets_detailscard.dart';
import 'package:emart/views/profile/edit_profileScreen.dart';
import 'package:emart/views/widgit_common/bg_widget.dart';
import 'package:emart/views/widgit_common/loading_indactor.dart';
import 'package:emart/views/wishlists/wish_lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    var controllerauth = Get.put(AuthController());
    FireStoreServices.getCounts();
    return bgwidget(
      Scaffold(
        body: user != null
            ? StreamBuilder(
                stream: FireStoreServices.getUser(user!.uid),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    var dataProfile = snapshot.data!;
                    return SafeArea(
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                controller.nameConroller.text =
                                    dataProfile['Name'];
                                Get.to(() =>
                                    Edit_profileScreen(data: dataProfile));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                dataProfile['ImageUrl'] == ""
                                    ? Image.asset(
                                        imgProfile2,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      )
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .make()
                                    : Image.network(
                                        dataProfile['ImageUrl'],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      )
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .make(),
                                10.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      "${dataProfile["Name"]}"
                                          .text
                                          .fontFamily(semibold)
                                          .white
                                          .make(),
                                      "${dataProfile["Email"]}"
                                          .text
                                          .white
                                          .make(),
                                    ],
                                  ),
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: whiteColor),
                                  ),
                                  onPressed: () async {
                                    await controllerauth.signOutMethod(context);
                                    Get.offAll(() => HomeScreen());
                                  },
                                  child: "LogOut"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                ),
                              ],
                            ),
                          ),
                          20.heightBox,
                          FutureBuilder(
                            future: FireStoreServices.getCounts(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: LoadingIndicator(),
                                );
                              } else {
                                var datacounts = snapshot.data;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7.0, right: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      detailsCard(
                                        count: "${datacounts[0]}",
                                        title: "In Your Cart",
                                        width: context.screenWidth / 3.5,
                                      ),
                                      detailsCard(
                                        count:
                                           "${datacounts[1]}",
                                        title: "In Your WishList",
                                        width: context.screenWidth / 3.2,
                                      ),
                                      detailsCard(
                                        count: "${datacounts[2]}",
                                        title: "Your Orders",
                                        width: context.screenWidth / 3.5,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Get.to(() => OdersScreen());
                                            break;
                                          case 1:
                                            Get.to(() => WishLists());
                                            break;
                                          case 2:
                                            Get.to(() => MessagesScreen());
                                            break;
                                        }
                                      },
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
              )
            : Center(
                child: Text('User is not logged in'),
              ),
      ),
    );
  }
}

import 'package:emart/consts/firebase_consts.dart';
import 'package:get/get.dart';

class HomeControler extends GetxController {
  var currentIndex = 0.obs;
  var userName = "";
  var userImage = "";
  @override
  onInit() {
    getuserName();
   
    super.onInit();
  }

  getuserName() async {
    var n = await firestore
        .collection(usercollection)
        .where("id", isEqualTo: user!.uid)
        .get()
        .then((value) {
      return value.docs.single['Name'];
    });
    userName == n;
  }

}

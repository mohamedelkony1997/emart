import 'package:emart/consts/firebase_consts.dart';

class FireStoreServices {
  static getUser(uid) {
    return firestore.collection(usercollection).doc(uid).snapshots();
  }
}

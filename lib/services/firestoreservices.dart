import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/firebase_consts.dart';

class FireStoreServices {
  static getUser(uid) {
    return firestore.collection(usercollection).doc(uid).snapshots();
  }

  static Stream<QuerySnapshot> getProducts(String category) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static Stream<QuerySnapshot> getCart(uid) {
    return firestore
        .collection(cartcollection)
        .where("addedBy", isEqualTo: uid)
        .snapshots();
  }

  static deleteCartItem(docUid) {
    return firestore.collection(cartcollection).doc(docUid).delete();
  }

  static Stream<QuerySnapshot> getChats(docId)  {
    return firestore
        .collection(chatcollection)
        .doc(docId)
        .collection(messagecollection)
        .orderBy("created_on", descending: false)
        .snapshots();
  }
}

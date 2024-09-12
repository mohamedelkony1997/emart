import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
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

  static Stream<QuerySnapshot> getChats(docId) {
    return firestore
        .collection(chatcollection)
        .doc(docId)
        .collection(messagecollection)
        .orderBy("created_on", descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> getAllOrders() {
    return firestore
        .collection(ordercollection)
        .where("order_by", isEqualTo: user!.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot> getAllWishlist() {
    return firestore
        .collection(productioncollection)
        .where("p_wishlist", arrayContains: user!.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot> getAllMessages() {
    return firestore
        .collection(chatcollection)
        .where("fromId", isEqualTo: user!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = Future.wait([
      firestore
          .collection(cartcollection)
          .where("addedBy", isEqualTo: user!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productioncollection)
          .where("p_wishlist", arrayContains: user!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordercollection)
          .where("order_by", isEqualTo: user!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allProducts() {
    return FirebaseFirestore.instance.collection('products').snapshots();
  }

  static getAllSubCategoryProducts(title) {
    return FirebaseFirestore.instance
        .collection(productioncollection)
        .where("p_subcategory", isEqualTo: title)
        .snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(productioncollection)
        .where("is Featured", isEqualTo: true)
        .get();
  }

  static getSearchProducts(title) {
    return firestore
        .collection(productioncollection)
        .where("p_name", isLessThanOrEqualTo: title)
        .get();
  }
}

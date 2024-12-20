import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? user = auth.currentUser;

const usercollection = "users";
const productioncollection = "products";
const cartcollection = "cart";
const chatcollection = "chats";
const messagecollection = "messages";
const ordercollection = "orders";

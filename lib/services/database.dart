
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
class DataBaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id,) async {
    return await
    FirebaseFirestore.
    instance.collection("users").
    doc(id).set(userInfoMap);
  }


  Future addUserOrderDetails(Map<String, dynamic> userOrderMap, String id,
      String orderId) async {
    return await
    FirebaseFirestore.
    instance.
    collection("users").doc(id).
    collection('Orders').doc(orderId).
    set(userOrderMap);
  }


  Future addAdminOrderDetails(Map<String, dynamic> userOrderMap,
      String orderId) async {
    return await
    FirebaseFirestore.
    instance.
    collection("Orders").doc(orderId).
    set(userOrderMap);
  }

 static Future <Stream<QuerySnapshot>>  getUserOrders(String id) async{
  return await FirebaseFirestore.instance.
  collection('users').
  doc(id).
  collection('Orders').
  orderBy('Timestamp', descending: true).
  snapshots();

  }

  Future<QuerySnapshot> getUserWalletbyemail(String email) async{
    return await FirebaseFirestore.instance.
    collection('users').
    where("Email", isEqualTo: email).
    get();
  }


  Future updateUserWallet(String amount, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
    .doc(id)
   . update({"Wallet":amount});
  }


   Future <Stream<QuerySnapshot>>  getAdminOrders( ) async{
    return await FirebaseFirestore.instance.

    collection('Orders').
    where("Status", isEqualTo: "Pending").
    snapshots();

  }

  Future updateAdminOrder(String id) async {
    return await FirebaseFirestore.instance
        .collection('Orders')
        .doc(id)
        . update({"Status":'Delivered'});
  }

  Future updateUserOrder(String userid, String docid) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userid).
         collection("Orders")
          .doc(docid)
        . update({"Status":'Delivered'});
  }



  Future DeleteUser(String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        . delete();
  }


   Future <Stream<QuerySnapshot>>  getAllUsers() async{
    return await FirebaseFirestore.instance.
    collection('users').

    snapshots();

  }


 static Future addUserTransaction(Map<String, dynamic> userTransactionMap, String id,) async {
    return await
    FirebaseFirestore.
    instance.
    collection("users").
    doc(id).
    collection('Transaction').
    add(userTransactionMap);
  }


 static Future <Stream<QuerySnapshot>>  getUsersTransactions(String id) async{
    return await FirebaseFirestore.instance.
    collection('users').doc(id).
        collection('Transaction').
    orderBy('Timestamp',descending: true).

    snapshots();

  }

  Future cancelAdminOrder(String orderId) async{
    return await FirebaseFirestore.instance.
    collection('Orders').
    doc(orderId).
    update({"Status":"Cancelled"});
  }
Future  cancelUserOrder(String userId, String orderId) async{
    return await FirebaseFirestore.instance.
    collection('users').
  doc(userId).
  collection('Orders').
  doc(orderId).
    update({"Status":"Cancelled"});
}


}
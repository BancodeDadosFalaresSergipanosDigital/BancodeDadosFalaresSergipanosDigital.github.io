import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreMethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //liberarAcesso
  Future<void> liberarAcesso(String uid) async {
    await _fireStore.collection('users').doc(uid).update({'approval_status': 3});
  }

  //negar acesso
  Future<void> negarAcesso(String uid) async {
    await _fireStore.collection('users').doc(uid).update({'approval_status': 2});
  }

  //apagar usuario
  Future<void> deleteUser(String uid) async {
    try {
      await _fireStore.collection('users').doc(uid).delete();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

}

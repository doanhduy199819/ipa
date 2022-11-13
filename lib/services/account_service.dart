import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';

mixin AccountService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<FirestoreUser?> getFirestoreUser(String userId) async {
    FirestoreUser? user;
    await _db.collection('users').doc(userId).get().then((value) {
      if (value.exists) {
        user = FirestoreUser.fromDocumentSnapshot(value);
      } else {
        user = null;
      }
    });
    if (user != null) {
      debugPrint('${user?.displayName ?? 'noname'}');
    }
    return user;
  }

  Future<bool> isNewUser(User user) async {
    bool res = false;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      res = value.exists;
    });
    return res;
  }

  Future<void> createNewUserDoc(User user) async {
    if (await isNewUser(user) == false) return;
    FirestoreUser account = FirestoreUser.fromFirebaseUser(user);
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(account.toJson());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/UserData.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';

mixin AccountService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<FirestoreUser?> getFirestoreUser(String userId) async {
    FirestoreUser? user;
    await _db.collection('users').doc(userId).get().then((value) {
      if (value.exists) {
        user = FirestoreUser.fromDocumentSnapshot(value);
      } else {
        user = null;
      }
    });
    return user;
  }

  Future<bool> isNewUser(User user) async {
    bool res = false;
    await _db.collection('users').doc(user.uid).get().then((value) {
      res = value.exists;
    });
    return res;
  }

  Future<void> createNewUserDoc(User user) async {
    if (await isNewUser(user) == false) return;
    FirestoreUser account = FirestoreUser.fromFirebaseUser(user);
    _db.collection('users').doc(user.uid).set(account.toJson());
  }

  Future<void> _updateUserNameCollectionFirestoreData(
      User user, String oldUserName) async {
    Map<String, String> toJSONData = {
      'user-id': user.uid,
    };
    // Add new
    _db.collection('usernames').doc(user.displayName).set(toJSONData);

    // Delete old name
    _db.collection('usernames').doc(oldUserName).delete();
  }

  Future<void> _updatePublicInfodata(User user) async {
    _db
        .collection('users')
        .doc(user.uid)
        .set(FirestoreUser.fromFirebaseUser(user).toJson());
  }

  Future<void> updateUserAuthInfo(User user, String oldDisplayName) async {
    _updatePublicInfodata(user);
    _updateUserNameCollectionFirestoreData(user, oldDisplayName);
  }

  Stream<UserData> get userData {
    return _db
        .collection('users')
        .doc(AuthService().currentUserId)
        .snapshots()
        .map(UserData.fromFirestore);
  }
}

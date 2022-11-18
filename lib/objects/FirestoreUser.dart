import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUser {
  String? uid;
  String? displayName;
  String? photoUrl;

  // String? avatar;
  // String? name;
  int? numberOfPost;
  int? numberOfGold;
  int? numberOfSilver;
  int? numberOfBronze;

  FirestoreUser(
      {
      // this.avatar,
      // this.name,
      this.numberOfPost,
      this.numberOfGold,
      this.numberOfSilver,
      this.numberOfBronze,
      this.uid,
      this.displayName,
      this.photoUrl});

  factory FirestoreUser.fromJson(Map<String, dynamic>? data) {
    return FirestoreUser(
      uid: data?['uid'],
      displayName: data?['displayName'],
      photoUrl: data?['photoUrl'],
    );
  }

  factory FirestoreUser.fromFirebaseUser(User? user) {
    return FirestoreUser(
      uid: user?.uid,
      displayName: user?.displayName,
      photoUrl: user?.photoURL,
    );
  }

  factory FirestoreUser.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return FirestoreUser.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {
        if (uid != null) 'uid': uid,
        if (displayName != null) 'displayName': displayName,
        if (photoUrl != null) 'photoUrl': photoUrl.toString(),
      };
}

// List<Account> listAccount = [
//   Account('https://cdn-icons-png.flaticon.com/512/1077/1077114.png?w=360',
//       'Trong Huy', 1010, 100, 100, 100),
//   Account('https://cdn-icons-png.flaticon.com/512/1077/1077114.png?w=360',
//       'Nhat Tan', 2871, 100, 100, 100)
// ];

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUser {
  String? uid;
  String? displayName;
  String? photoUrl;

  List<String>? savedArticles;
  List<String>? savedQuestions;
  List<String>? followingUsers;

  FirestoreUser({
    this.uid,
    this.displayName,
    this.photoUrl,
    this.savedArticles,
    this.savedQuestions,
    this.followingUsers,
  });

  factory FirestoreUser.fromJson(Map<String, dynamic>? data) {
    return FirestoreUser(
      uid: data?['uid'],
      displayName: data?['displayName'],
      photoUrl: data?['photoUrl'],
      savedArticles: data?['savedArticles'] is Iterable
          ? List.from(data?['savedArticles'])
          : null,
      savedQuestions: data?['savedQuestions'] is Iterable
          ? List.from(data?['savedQuestions'])
          : null,
      followingUsers: data?['followingUsers'] is Iterable
          ? List.from(data?['followingUsers'])
          : null,
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
        if (savedArticles != null) 'savedArticles': savedArticles,
        if (savedQuestions != null) 'savedQuestions': savedQuestions,
        if (followingUsers != null) 'followingUsers': followingUsers,
      };
}
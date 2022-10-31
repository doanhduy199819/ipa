import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';

class UserData {
  String? id;
  List<ArticlePost>? savedArticles;

  UserData({this.id, this.savedArticles});

  Map<String, dynamic> toJson() => {
        'id': id,
        if (savedArticles != null) 'savedArticles': savedArticles,
      };

  factory UserData.fromJson(Map<String, dynamic>? data) {
    return UserData(
      id: data?['id'],
      savedArticles: data?['savedArticles'],
    );
  }

  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return UserData.fromJson(documentSnapshot.data());
  }
}

abstract class UserDataFirestoreHandle {
  void updateSavedArticles(List<ArticlePost>? list);
  Future<UserData?> get userData;
  Future updateUserData(UserData? userData);
  UserData? userDataFromDocumentSnapshot(DocumentSnapshot documentSnapshot);
}

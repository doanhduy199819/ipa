import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class UserData {
  String? id;
  List<ArticlePost>? savedArticles;
  List<Question>? savedQuestions;
  List<String>? followingUsers;

  static Stream<UserData?> get userData {
    return DatabaseService().userData;
  }

  UserData._(
      {this.id,
      this.savedArticles,
      required savedQuestions,
      required followingUsers});

  Map<String, dynamic> toJson() => {
        'id': id,
        if (savedArticles != null) 'savedArticles': savedArticles,
        if (savedQuestions != null) 'savedQuestions': savedQuestions,
        if (followingUsers != null) 'followingUsers': followingUsers,
      };

  factory UserData.fromJson(Map<String, dynamic>? data) {
    return UserData._(
      id: data?['id'],
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

  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return UserData.fromJson(documentSnapshot.data());
  }

  void update() {}
}

abstract class UserDataFirestoreHandle {
  void updateSavedArticles(List<ArticlePost>? list);
  Future<UserData?> get userData;
  Future updateUserData(UserData? userData);
  UserData? userDataFromDocumentSnapshot(DocumentSnapshot documentSnapshot);
}

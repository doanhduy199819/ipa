import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/pages/authentication/authenticate.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/controller/question_controller.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import '../objects/Job.dart';
import '../objects/RecentlyQuiz.dart';
import '../objects/SetOfQuiz.dart';
import '../pages/quiz_screen/quiz/object/question.dart';

mixin RecentlyQuizService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> checkUserExits() async {
    // print("id user: ${AuthService().currentUserId}");
    CollectionReference collection = _db.collection('users');
    List<bool> result = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          // print("data id user  ${doc.id}");
          if (doc.id == AuthService().currentUserId.toString()) return true;
          return false;
        }
        return false;
      }).toList();
    });
    for (int i = 0; i < result.length; i++) {
      // print(result.toString());
      if (result[i]) return true;
    }

    return false;
  }

  Future<List<RecentlyQuiz>> getRecentlyQuiz() async {
    if (await checkUserExits() == false) {
      return [];
    }
    CollectionReference collection = _db
        .collection('users')
        .doc(AuthService().currentUserId)
        .collection('recentlyquiz');

    List<RecentlyQuiz> result = [];
    await collection
        .orderBy("timecreated", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          RecentlyQuiz a = RecentlyQuiz.fromJson(data);
          return a;
        }
        return RecentlyQuiz();
      }).toList();
    });
    return result;
  }

  Future<void> updateRecentlyQuiz() async {
    if (await checkUserExits() == false) {
      return;
    }
    int getHighScoreFromFirebase = await DatabaseService().getHightScoreQuiz(
      QuesionController.dataBoxCategories.jobid,
      QuesionController.dataBoxCategories.categoriesid,
      QuesionController.setOfQuiz.id,
    );
    int getScoreQuiz = QuesionController().getScoreQuiz();
    int maxScore = getHighScoreFromFirebase > getScoreQuiz
        ? getHighScoreFromFirebase
        : getScoreQuiz;
    await _db
        .collection('users')
        .doc(AuthService().currentUserId)
        .collection('recentlyquiz')
        .doc(QuesionController.recentlyQuizId.toString())
        .update({
      'highscore': maxScore,
      'timecreated': Timestamp.now(),
    });
  }

  Future<void> addRecentlyQuiz() async {
    if (await checkUserExits() == false) {
      return;
    }

    final quiz = RecentlyQuiz.createdNow().toJson();
    _db
        .collection("users")
        .doc(AuthService().currentUserId)
        .collection('recentlyquiz')
        .add(quiz)
        .then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}

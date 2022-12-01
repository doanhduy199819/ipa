import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/controller/question_controller.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import '../objects/Job.dart';
import '../objects/RecentlyQuiz.dart';
import '../objects/SetOfQuiz.dart';
import '../pages/quiz_screen/quiz/object/question.dart';

mixin QuizService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<String>?> getDesciptionQuiz(
      String? jobId, String? categoriesId, String? setOfQuizId) async {
    CollectionReference collection = _db
        .collection('quizzes')
        .doc(jobId)
        .collection('categories')
        .doc(categoriesId)
        .collection('setofquestion')
        .doc(setOfQuizId)
        .collection('description');

    List<String>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          String a = data?["content"];
          return a;
        }
        return "";
      }).toList();
    });
    return result;
  }

  Future<List<Answers>?> getAnswersWithQuestion(String? jobId,
      String? categoriesId, String? setOfQuizId, String? questionId) async {
    CollectionReference collection = _db
        .collection('quizzes')
        .doc(jobId)
        .collection('categories')
        .doc(categoriesId)
        .collection('setofquestion')
        .doc(setOfQuizId)
        .collection('question')
        .doc(questionId)
        .collection('answers');

    List<Answers>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          Answers a = Answers.fromJson(data);
          return a;
        }
        return Answers();
      }).toList();
    });
    return result;
  }

  Future<List<QuizQuestion>?> getQuestionOfQuiz(
      String? jobId, String? categoriesId, String? setOfQuizId) async {
    CollectionReference collection = _db
        .collection('quizzes')
        .doc(jobId)
        .collection('categories')
        .doc(categoriesId)
        .collection('setofquestion')
        .doc(setOfQuizId)
        .collection('question');

    List<QuizQuestion>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          QuizQuestion a = QuizQuestion.fromJson(data, doc.id);
          return a;
        }
        return QuizQuestion();
      }).toList();
    });
    return result;
  }

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

  Future<int> getHightScoreQuiz(
      String? jobId, String? categoriesId, String? setOfQuizId) async {
    if (await checkUserExits() == false) {
      return 0;
    }
    CollectionReference collection = _db
        .collection('users')
        .doc(AuthService().currentUserId)
        .collection('recentlyquiz');
    List<RecentlyQuiz>? listRecently;
    await collection.get().then((QuerySnapshot querySnapshot) {
      listRecently = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          RecentlyQuiz a = RecentlyQuiz.fromJsonWithID(data, doc.id);
          return a;
        }
        return RecentlyQuiz();
      }).toList();
    });
    int result = 0;
    for (int i = 0; i < (listRecently ?? []).length; i++) {
      if (listRecently![i].jobId == jobId &&
          listRecently![i].categoriesId == categoriesId &&
          listRecently![i].quizId == setOfQuizId) {
        QuesionController.recentlyQuizId = listRecently![i].id ?? "";
        result = listRecently![i].highScore ?? 0;
      }
    }
    return result;
  }
}

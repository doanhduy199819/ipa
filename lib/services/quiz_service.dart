import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../objects/Job.dart';
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

  Future<List<Question>?> getQuestionOfQuiz(
      String? jobId, String? categoriesId, String? setOfQuizId) async {
    CollectionReference collection = _db
        .collection('quizzes')
        .doc(jobId)
        .collection('categories')
        .doc(categoriesId)
        .collection('setofquestion')
        .doc(setOfQuizId)
        .collection('question');

    List<Question>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          Question a = Question.fromJson(data, doc.id);
          return a;
        }
        return Question();
      }).toList();
    });
    return result;
  }
}

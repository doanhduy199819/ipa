import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../objects/Job.dart';
import '../objects/SetOfQuiz.dart';

mixin SetOfQuizService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<SetOfQuiz>?> getSetOfQuizList(
      String? jobId, String? categoriesId) async {
    CollectionReference collection = _db
        .collection('quizzes')
        .doc(jobId)
        .collection('categories')
        .doc(categoriesId)
        .collection('setofquestion');

    List<SetOfQuiz>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          SetOfQuiz a = SetOfQuiz.fromJson(data, doc.id);
          return a;
        }
        return SetOfQuiz();
      }).toList();
    });
    return result;
  }
}

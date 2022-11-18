import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/data_questions.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

mixin QAService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Question>? _questionsListFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<Question>? res;
    res = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Question.fromJson(documentSnapshot.data());
      }
      return Question.test();
    }).toList();
    return res;
  }

  Stream<List<Question>?> get allQuestions {
    return _db
        .collection('questions')
        .snapshots()
        .map(_questionsListFromQuerySnapshot);
  }

  Future<List<Question>?> get allQuestionsOnce {
    return _db
        .collection('questions')
        .get()
        .then(_questionsListFromQuerySnapshot);
  }

  void addListQuestions(List<Question> list) {
    list.forEach((question) => addQuestion(question));
  }

  void addQuestion(Question question) async {
    DocumentReference doc = _db.collection('questions').doc();
    String doc_id = doc.id;
    if (question.id == null) question.setId(doc_id);
    String? user_id = AuthService().currentUserId;
    question.setAuthorId(user_id);

    // Add question to firebase
    doc
        .set(question.toJson())
        .then((value) => print('Question added successfully'))
        .catchError((error) => print('Failed to add a question: ${error}'));

    // Add question answers to firebase
    CollectionReference subcollection =
        _db.collection('questions').doc(doc_id).collection('answers');
    question.answers?.forEach((element) => subcollection.add(element.toJson()));
  }
}

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/data_questions.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

mixin QAService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Question>? _questionsListFromQuerySnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return Question.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      }
      return Question.test();
    }).toList();
  }

  Stream<List<Question>?> get allQuestions {
    return _db
        .collection('questions')
        .snapshots()
        .map(_questionsListFromQuerySnapshot);
  }

  Future<List<Question>?> allQuestionsOnce() async {
    CollectionReference collection = _db.collection('questions');
    // return a QuerySnapshot, which is a collection query
    // To access documents in a collection,
    // querySnapshot.docs() => return a List<DocumentSnapshot>
    List<Question>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      // print(querySnapshot.docs.first.data());
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          Question a = Question.fromJson(data);
          return a;
        }
        return Question.test();
      }).toList();
    });
    return result;
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

    // question.answers?.forEach((comment) {
    //   DatabaseService().addCommentToQuestion(comment.content ?? '', question.id!);
    // });
  }
}
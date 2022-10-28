import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_interview_preparation/objects/Questions.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';

class DatabaseQAService {
  // DatabaseReference ref = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;

   List<Question>? _articlesListFromQuerySnapshot(
      QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return Question.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      }
      return Question.test();
    }).toList();
  }

  Stream<List<Question>?> get articlesList {
    return db
        .collection('articles')
        .snapshots()
        .map(_articlesListFromQuerySnapshot);
  }
  void testReadArticles() async {
    await db.collection('company').get().then((event) {
      for (var doc in event.docs) {
        print("id: ${doc.id} => data: ${doc.data()}");
      }
    });
  }

  void addListQuestion(List<Question> list) {
    CollectionReference collection = db.collection('question');
    list.forEach((question) {
      collection
          .add(question.toJson())
          .then((value) => print('Question added successfully'))
          .catchError((onError) => print('Failed to add a question'));
    });
  }

  void addQuestion(Question question) async {
    DocumentReference doc = db.collection('question').doc();
    String doc_id = doc.id;
    if (question.id == null) question.setId(doc_id);
    String? user_id = AuthService().currentUserId;
    question.setAuthorId(user_id);
    doc
        .set(question.toJson())
        .then((value) => print('Question added successfully'))
        .catchError((error) => print('Failed to add a question'));
  }

  Future<List<Question>?> getQuestionsList() async {
    CollectionReference collection = db.collection('question');
    // return a QuerySnapshot, which is a collection query
    // To access documents in a collection,
    // querySnapshot.docs() => return a List<DocumentSnapshot>
     List<Question>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      // print(querySnapshot.docs.first.data());
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          Question a =  Question.fromJson(data);
          return a;
        }
        return Question.test();
      }).toList();
    });
    return result;
  }
}

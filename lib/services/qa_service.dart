import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/objects/UserData.dart';
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

  Stream<int> getVoteNum(String questionId) {
    return _db
        .collection('questions')
        .doc(questionId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      List<String>? upVoteList = data?['upvote_users'] is Iterable
          ? List.from(data?['upvote_users'])
          : null;
      List<String>? downVoteList = data?['downvote_users'] is Iterable
          ? List.from(data?['downvote_users'])
          : null;
      return (upVoteList?.length ?? 0) - (downVoteList?.length ?? 0);
    });
  }

  Stream<int> getNumberOfAnswers(String questionId) {
    return _db
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
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

  // Check if this user already upvote this comment
  Future<bool> isAlreadyVoteQuestion(Question question, bool isUp) async {
    if (AuthService().currentUserId == null) {
      throw Exception('No user');
    }
    bool res = false;
    String userId = AuthService().currentUserId!;
    await _db.collection('questions').doc(question.id).get().then((docSnap) {
      final data = docSnap.data();
      debugPrint('has data');
      List<String>? list =
          data?[(isUp) ? 'upvote_users' : 'downvote_users'] is Iterable
              ? List.from(data?[(isUp) ? 'upvote_users' : 'downvote_users'])
              : null;
      res = list?.contains(userId) ?? false;
    });
    return res;
  }

  Stream<int> voteState(Question question) {
    String userId = AuthService().currentUserId!;
    return _db
        .collection('questions')
        .doc(question.id)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      List<String>? upVoteList = data?['upvote_users'] is Iterable
          ? List.from(data?['upvote_users'])
          : null;
      List<String>? downVoteList = data?['downvote_users'] is Iterable
          ? List.from(data?['downvote_users'])
          : null;
      if (upVoteList?.contains(userId) ?? false) {
        return 1;
      } else if (downVoteList?.contains(userId) ?? false) {
        return -1;
      }
      return 0;
    });
  }

  void upVoteQuestion(Question question, bool active) {
    if (active) {
      _db.collection('questions').doc(question.id).update({
        "upvote_users": FieldValue.arrayUnion([AuthService().currentUserId]),
      });
      debugPrint('Upvote success');
    } else {
      _db.collection('questions').doc(question.id).update({
        "upvote_users": FieldValue.arrayRemove([AuthService().currentUserId]),
      });
      debugPrint('remove Upvote success');
    }
  }

  void downVoteQuestion(Question question, bool active) {
    if (active) {
      _db.collection('questions').doc(question.id).update({
        "downvote_users": FieldValue.arrayUnion([AuthService().currentUserId]),
      });
      debugPrint('Downvote success');
    } else {
      _db.collection('questions').doc(question.id).update({
        "downvote_users": FieldValue.arrayRemove([AuthService().currentUserId]),
      });
      debugPrint('remove Downvote success');
    }
  }

  Future<bool> isQuestionInUserSaved(Question question) async {
    bool res = false;
    DocumentReference docRef =
        _db.collection('users').doc(AuthService().currentUserId);
    await docRef.get().then((value) {
      if (!value.exists) return;
      final data = value.data() as Map<String, dynamic>?;
      List<String>? savedArticlesIds = data?['savedQuestions'] is Iterable
          ? List.from(data?['savedQuestions'])
          : null;
      res = savedArticlesIds?.contains(question.id) ?? false;
    });
    return res;
  }

  Future<void> saveQuestion(Question question) async {
    _db
        .collection('users')
        .doc(AuthService().currentUserId)
        .update({
          "savedQuestions": FieldValue.arrayUnion([question.id]),
        })
        .then((_) => debugPrint('Save question completed: ${question.id}'))
        .onError(
            (error, stackTrace) => debugPrint('Error ${error.toString()}'));
  }

  Future<void> unSaveQuestion(Question question) async {
    _db
        .collection('users')
        .doc(AuthService().currentUserId)
        .update({
          "savedQuestions": FieldValue.arrayRemove([question.id]),
        })
        .then(
            (_) => debugPrint('Remove saved question completed: ${question.id}'))
        .onError(
            (error, stackTrace) => debugPrint('Error ${error.toString()}'));
  }

  Future<List<Question>?> get savedQuestions async {
    final docSnapshot = await _db
        .collection('users')
        .doc(AuthService().currentUser?.uid ?? '')
        .get();
    final userData = UserData.fromFirestore(docSnapshot);

    return await _db
        .collection('questions')
        .where("id", whereIn: userData.savedArticles)
        .get()
        .then(_questionsListFromQuerySnapshot);
  }
}

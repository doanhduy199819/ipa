import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';

mixin CommentService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addCommentToArticle(String content, String articleId) {
    Comment comment = Comment.createdNowFromCurrentUser(content);
    DocumentReference docRef =
        _db.collection('articles').doc(articleId).collection('comments').doc();
    comment.id ??= docRef.id;
    comment.author_id ??= AuthService().currentUserId;
    return docRef.set(comment.toJson()).then((_) {
      debugPrint(
          'New comment is added to aritcle $articleId\n with id ${docRef.id}');
    });
  }

  Future<void> addCommentToQuestion(String content, String questionId) {
    Comment comment = Comment.createdNowFromCurrentUser(content);
    DocumentReference docRef =
        _db.collection('questions').doc(questionId).collection('comments').doc();
    comment.id ??= docRef.id;
    comment.author_id ??= AuthService().currentUserId;
    return docRef.set(comment.toJson()).then((_) {
      debugPrint(
          'New comment is added to question $questionId\n with id ${docRef.id}');
    });
  }

  Stream<List<Comment>?> commentsFromArticle(String articleId) {
    return _db
        .collection('articles')
        .doc(articleId)
        .collection('comments')
        .orderBy("created_at", descending: false)
        .snapshots()
        .map(commentsFromQuerySnapshot);
  }

  Stream<List<Comment>?> commentsFromQuestion(questionID) {
    return _db
        .collection('questions')
        .doc(questionID)
        .collection('answers')
        .orderBy("created_at", descending: false)
        .snapshots()
        .map(commentsFromQuerySnapshot);
  }

  Future<void> deleteCommentFromArticle(
      String commentId, String articleId) async {
    _db
        .collection('articles')
        .doc(articleId)
        .collection('comments')
        .doc(commentId)
        .delete();
  }

  Future<void> deleteCommentFromQuestion(
      String commentId, String articleId) async {
    _db
        .collection('questions')
        .doc(articleId)
        .collection('answers')
        .doc(commentId)
        .delete();
  }

  List<Comment>? commentsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Comment.fromQuerySnapshot(documentSnapshot);
      }
      return Comment();
    }).toList();
  }

  // Check if this user already upvote this comment
  bool _isUpvote(Comment comment) {
    if (AuthService().currentUserId == null) {
      throw Exception('No user');
    }
    bool res = false;
    String userId = AuthService().currentUserId!;
    _db.collection('questions').doc(comment.id).get().then((docSnap) {
      final data = docSnap.data();
      List<String>? list = data?['upvote_users'] is Iterable
          ? List.from(data?['upvote_users'])
          : null;
      res = list?.contains(userId) ?? false;
    });
    return res;
  }

  void upVote(Comment comment) {
    if (!_isUpvote(comment)) {
      debugPrint('This user already upvoted this comment');
      return;
    }
    _db.collection('questions').doc(comment.id).update({
      "answers": FieldValue.arrayUnion([AuthService().currentUserId]),
    });
    debugPrint('Upvote success');
  }
}

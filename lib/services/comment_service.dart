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
        _db.collection('questions').doc(questionId).collection('answers').doc();
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

  Stream<int> getCommentVoteNum(String questionId, String commentId) {
    return _db
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .doc(commentId)
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

  // Check if this user already upvote this comment
  Future<bool> isUpvoteComment(String questionId, String commentId, bool isUp) async {
    if (AuthService().currentUserId == null) {
      throw Exception('No user');
    }
    bool res = false;
    String userId = AuthService().currentUserId!;
    await _db
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .doc(commentId)
        .get()
        .then((docSnap) {
      final data = docSnap.data();
      List<String>? list =
          data?[(isUp) ? 'upvote_users' : 'downvote_users'] is Iterable
              ? List.from(data?[(isUp) ? 'upvote_users' : 'downvote_users'])
              : null;
      res = list?.contains(userId) ?? false;
    });
    return res;
  }

  void upVoteComment(String questionId, String commentId, bool active) {
    if (active) {
      _db.collection('questions').doc(questionId).collection('answers').doc(commentId).update({
        "upvote_users": FieldValue.arrayUnion([AuthService().currentUserId]),
      });
      debugPrint('Upvote success');
    } else {
      _db.collection('questions').doc(questionId).collection('answers').doc(commentId).update({
        "upvote_users": FieldValue.arrayRemove([AuthService().currentUserId]),
      });
      debugPrint('remove Upvote success');
    }
  }

  void downVoteComment(String questionId, String commentId, bool active) {
    if (active) {
      _db.collection('questions').doc(questionId).collection('answers').doc(commentId).update({
        "downvote_users": FieldValue.arrayUnion([AuthService().currentUserId]),
      });
      debugPrint('Downvote success');
    } else {
      _db.collection('questions').doc(questionId).collection('answers').doc(commentId).update({
        "downvote_users": FieldValue.arrayRemove([AuthService().currentUserId]),
      });
      debugPrint('remove Downvote success');
    }
  }
}

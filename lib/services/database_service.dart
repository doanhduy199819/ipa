import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/services/articles_service.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/comment_service.dart';

class DatabaseService with ArticlePostHandle implements CommentService {
  @override
  Future<void> addCommentToArticle(Comment comment, String articleId) {
    DocumentReference docRef =
        db.collection('articles').doc(articleId).collection('comments').doc();
    comment.id ??= docRef.id;
    comment.author_id ??= AuthService().currentUserId;
    return docRef.set(comment.toJson()).then((_) {
      print(
          'New comment is added to aritcle $articleId\n with id ${docRef.id}');
    });
  }

  @override
  Stream<List<Comment>?> commentsFromArticle(String articleId) {
    db
        .collection('articles')
        .doc(articleId)
        .collection('comments')
        .snapshots()
        .listen((event) {
      print(event.docs);
    });

    return db
        .collection('articles')
        .doc(articleId)
        .collection('comments')
        .snapshots()
        .map(commentsFromQuerySnapshot);
  }

  @override
  List<Comment>? commentsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists)
        return Comment.fromQuerySnapshot(documentSnapshot);
      return Comment();
    }).toList();
  }
}

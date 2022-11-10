import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/services/articles_service.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/comment_service.dart';

class DatabaseService with ArticlePostHandle implements CommentService {
  @override
  Future<void> addCommentToArticle(String content, String articleId) {
    Comment comment = Comment.createdNowFromCurrentUser(content);
    DocumentReference docRef =
        db.collection('articles').doc(articleId).collection('comments').doc();
    comment.id ??= docRef.id;
    comment.author_id ??= AuthService().currentUserId;
    return docRef.set(comment.toJson()).then((_) {
      debugPrint(
          'New comment is added to aritcle $articleId\n with id ${docRef.id}');
    });
  }

  @override
  Stream<List<Comment>?> commentsFromArticle(String articleId) {
    return db
        .collection('articles')
        .doc(articleId)
        .collection('comments')
        .orderBy("created_at", descending: false)
        .snapshots()
        .map(commentsFromQuerySnapshot);
  }

  void postSampleArticle() {
    ArticlePost articlePost =
        ArticlePost.only(title: 'Testing comments', content: 'Nothing much');
    articlePost.comments = Comment.getSampleCommentsList();
    addArticle(articlePost);
  }

  void addListArticles(List<ArticlePost> list) {
    CollectionReference collection = db.collection('articles');
    list.forEach((article) {
      collection
          .add(article.toJson())
          .then((value) => print('Article added successfully'))
          .catchError((onError) => print('Failed to add an article'));
    });
  }

  void addArticle(ArticlePost article) async {
    DocumentReference doc = db.collection('articles').doc();
    String doc_id = doc.id;
    if (article.id == null) article.setId(doc_id);
    String? user_id = AuthService().currentUserId;
    article.setAuthorId(user_id);
    doc
        .set(article.toJson())
        .then((value) => print('Article added successfully'))
        .catchError((error) => print('Failed to add an article'));
  }

  Future<List<ArticlePost>?> getArticlesList() async {
    CollectionReference collection = db.collection('articles');
    // return a QuerySnapshot, which is a collection query
    // To access documents in a collection,
    // querySnapshot.docs() => return a List<DocumentSnapshot>
    List<ArticlePost>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      // print(querySnapshot.docs.first.data());
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          ArticlePost a = ArticlePost.fromJson(data);
          return a;
        }
        return ArticlePost.test();
      }).toList();
    });
    return result;
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

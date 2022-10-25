import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';

class DatabaseService {
  // DatabaseReference ref = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<ArticlePost>? _articlesListFromQuerySnapshot(
      QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return ArticlePost.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      }
      return ArticlePost.test();
    }).toList();
  }

  Stream<List<ArticlePost>?> get articlesList {
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

  void addListArticles(List<ArticlePost> list) {
    CollectionReference collection = db.collection('articles');
    list.forEach((article) {
      collection
          .add(article.toJson())
          .then((value) => print('Article added successfully'))
          .catchError((onError) => print('Failed to add an article'));
    });
  }

  void addArticle(ArticlePost article) {
    // CollectionReference collection = db.collection('articles');
    DocumentReference doc = db.collection('articles').doc();
    String id = doc.id;
    if (article.id == null) article.setId(id);
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
}
